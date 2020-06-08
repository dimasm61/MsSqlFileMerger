using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Text;
using System.Threading.Tasks;

namespace MsSqlFileMerger
{
    public partial class SqlFileMergeHelper
    {
        private readonly ConcurrentQueue<ParseFileTask> _taskQueue = new ConcurrentQueue<ParseFileTask>();

        public class ParseFileTask
        {
            public ParseFileTask(string fileName, Encoding enc, int order, bool isSpToEndFile)
            {
                FileName = fileName;
                Enc = enc;
                CreateOrder = order;
                IsSpToEndFile = isSpToEndFile;
            }

            public string FileName;
            public Encoding Enc;
            public int CreateOrder;
            public bool IsSpToEndFile;
        }

        public void LoadParallel(string dbName
            //, string rootPath
            , Encoding encoding
            , string[] sqlSourceFolders
            , bool isSpToEndFile
            , string searchPattern = "*.sql"
            , string[] excludeFileList = null
            , int taskCount = 10
            )
        {
            try
            {
                _dbName = dbName;

                _sqlObjectList.Clear();

                var rootPath = Path.Combine(SolutionPath, _scriptRootFolder);

                // var readedFiles = new List<string>();
                var outputList = new List<LogItem>();

                _createOrderCounter = 0;
                var order = 0;

                var doneFilesDict = new Dictionary<string, string>();

                // create parse task queue
                foreach (var sqlFolder in sqlSourceFolders)
                {
                    var folder = Path.Combine(rootPath, sqlFolder);

                    if (!Directory.Exists(folder))
                    {
                        if (Output != null)
                            Output.WriteLine($"-- Path not found '{folder}'");
                        else
                            Trace.TraceError($"-- Path not found '{folder}'");
                        continue;
                    }

                    var files = Directory.GetFiles(folder, "*.sql", SearchOption.TopDirectoryOnly);
                    foreach (var sqlFile in files)
                    {

                        if (doneFilesDict.ContainsKey(sqlFile))
                            continue;

                        // WriteLine($"-- {sqlFile}");

                        if (!File.Exists(sqlFile))
                        {
                            if (Output != null)
                                Output.WriteLine($"-- File not found '{sqlFile}'");
                            else
                                Trace.TraceError($"-- File not found '{sqlFile}'");

                            continue;
                        }

                        var file = Path.GetFileName(sqlFile);

                        if (excludeFileList != null && excludeFileList.Contains(file))
                            continue;

                        if (!string.IsNullOrEmpty(sqlFile) && sqlFile.ToLower().Contains("ignore"))
                            continue;


                        // instead of parse file, add it to queue
                        _taskQueue.Enqueue(new ParseFileTask(sqlFile, encoding, order++, isSpToEndFile));
                        doneFilesDict.Add(sqlFile, sqlFile);

                        // var parsedObjects = _sqlFileLoader.LoadFile(Output, sqlFile, encoding, ref _createOrderCounter, isSpToEndFile, outputList);
                        // 
                        // foreach (var parsedObject in parsedObjects)
                        // {
                        //     _sqlObjectList.Add(parsedObject);
                        // }

                    }//foreach( var sqlFile in files)
                }//foreach(var sqlFolder in sqlFolders)


                var taskList = new List<Task>();
                // run queue processing in some threads(tasks)
                while (taskList.Count < taskCount)
                {
                    var task = Task.Run(() => ProcessingTaskQueue(outputList));
                    taskList.Add(task);
                    Task.Delay(1);
                }


                // wait 
                Task.WaitAll(taskList.ToArray());

                // write output - there are can be parse errors
                LogItem.WriteList(Output, outputList);

            }
            catch (Exception ex)
            {
                if (Output != null)
                    Output.WriteLine($"-- Error in {nameof(Load)}, {ex.Message}");
                else
                    Trace.TraceError($"-- Error in {nameof(Load)}, {ex.Message}");
            }
        }

        public void ProcessingTaskQueue(List<LogItem> outputList)
        {
            while (_taskQueue.Any())
            {
                ParseFileTask x;

                var cn = 0;
                while (!_taskQueue.TryDequeue(out x) && _taskQueue.Any() && cn++ < 100)
                    Task.Delay(5);

                try
                {
                    DoParseFileTask(x, outputList);
                }
                catch (Exception ex)
                {
                    outputList.Add($"{nameof(DoParseFileTask)} {ex.Message}");
                    outputList.Add($"{nameof(DoParseFileTask)} {ex.StackTrace}");
                }

            }// while
        }

        public void DoParseFileTask(ParseFileTask parseTask, List<LogItem> outputList)
        {
            var parsedObjects = _sqlFileLoader.LoadFile(
                SolutionPath
                , parseTask.FileName
                , parseTask.Enc
                , ref _createOrderCounter
                , parseTask.IsSpToEndFile
                , outputList);

            if (parsedObjects == null || parsedObjects?.Any() == false)
            {
                var fileName = parseTask.FileName;
                SqlObjectWriter.ClearFileName(SolutionPath, ref fileName);
                outputList.Add($"didn't found sp/func/view in file {fileName}");
                return;
            }

            foreach (var parsedObject in parsedObjects)
            {
                parsedObject.CreateOrder = parseTask.CreateOrder;
                _sqlObjectList.Add(parsedObject);
            }
        }
    }
}
