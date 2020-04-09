using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Diagnostics.Eventing.Reader;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualStudio.TextTemplating;

namespace MsSqlFileMerger
{
    public partial class SqlFileMergeHelper : IMerger, IMergerForTest
    {
        private string _dbName = "";
        private SqlObjectWriter _sqlObjectWriter;
        private List<SqlObject> _sqlObjectList;
        private SqlObjectParser _parser;
        private ISqlFileLoader _sqlFileLoader;

        public bool IsTraceIfFindIgnoreKeyword
        {
            get => _sqlFileLoader.IsTraceIfFindIgnoreKeyword;
            set => _sqlFileLoader.IsTraceIfFindIgnoreKeyword = value;
        }

        public string ScriptRootPath=> Path.Combine(SolutionPath, _scriptRootFolder);

        public string SolutionPath
        {
            get => _sqlObjectWriter.SolutionDir;
            set => _sqlObjectWriter.SolutionDir = value;
        }

        private string _scriptRootFolder;

        public void SetScriptRootFolder(string solutionPath, string scriptRootFolder)
        {
            SolutionPath = solutionPath.Trim('\\');

            _scriptRootFolder = scriptRootFolder.Trim('\\');

            if(!Directory.Exists(ScriptRootPath))
                throw new Exception($"Не удалось найти путь {ScriptRootPath}, проверьте аргументы {nameof(SetScriptRootFolder)}");
        }

        #region _sqlObjectWriter wrippers
        public TextTransformation Output
        {
            get => _sqlObjectWriter.Output;
            set => _sqlObjectWriter.Output = value;
        }

        public string RowDelimiterDropCreate
        {
            get => _sqlObjectWriter.RowDelimiterDropCreate;
            set => _sqlObjectWriter.RowDelimiterDropCreate = value;
        }
        public string RowDelimiterObject
        {
            get => _sqlObjectWriter.RowDelimiterObject;
            set => _sqlObjectWriter.RowDelimiterObject = value;
        }
        public bool IsWriteGenOrder
        {
            get => _sqlObjectWriter.IsWriteGenOrder;
            set => _sqlObjectWriter.IsWriteGenOrder = value;
        }
        public bool IsWriteFileName
        {
            get => _sqlObjectWriter.IsWriteFileName;
            set => _sqlObjectWriter.IsWriteFileName = value;
        }
        #endregion

        private int _createOrderCounter;

        public SqlFileMergeHelper()
        {
            _sqlObjectList = new List<SqlObject>();
            _sqlObjectWriter = new SqlObjectWriter();
            _sqlObjectList = new List<SqlObject>();
            _parser = new SqlObjectParser();

            _sqlFileLoader = new SqlObjectFileLoader();
            _sqlFileLoader.Init(_parser);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="dbName">Name of data base, need for 'use MyDataBase;go;'</param>
        /// <param name="rootPath">Root path where helper will try to find folders (from sqlSourceFolders array)</param>
        /// <param name="encoding">Sql files encoding</param>
        /// <param name="sqlSourceFolders">Array of folders with sql code files</param>
        /// <param name="isSpToEndFile"></param>
        /// <param name="searchPattern">Search pattern for search of files with sql code, by default '*.sql'</param>
        /// <param name="excludeFileList">Array of short file names (without path) which need ignore</param>
        public void Load(string dbName
            , string rootPath
            , Encoding encoding
            , string[] sqlSourceFolders
            , bool isSpToEndFile
            , string searchPattern = "*.sql"
            , string[] excludeFileList = null)
        {
            try
            {
                _dbName = dbName;

                _sqlObjectList.Clear();

                var readedFiles = new List<string>();
                var outputList = new List<LogItem>();
                _createOrderCounter = 0;

                foreach (var sqlFolder in sqlSourceFolders)
                {
                    var folder = Path.Combine(rootPath, sqlFolder);

                    if (!Directory.Exists(folder))
                    {
                        outputList.Add($"-- Path not found '{folder}'");
                        continue;
                    }


                    var files = Directory.GetFiles(folder, "*.sql", SearchOption.TopDirectoryOnly);
                    foreach (var sqlFile in files)
                    {
                        // WriteLine($"-- {sqlFile}");

                        if (!File.Exists(sqlFile))
                        {
                            outputList.Add($"-- File not found '{sqlFile}'");

                            continue;
                        }

                        var file = Path.GetFileName(sqlFile);

                        if (excludeFileList != null && excludeFileList.Contains(file))
                            continue;

                        if (!string.IsNullOrEmpty(sqlFile) && sqlFile.ToLower().Contains("ignore"))
                            continue;

                        var parsedObjects = _sqlFileLoader.LoadFile( SolutionPath, sqlFile, encoding, ref _createOrderCounter, isSpToEndFile, outputList);

                        foreach (var parsedObject in parsedObjects)
                        {
                            _sqlObjectList.Add(parsedObject);
                        }

                        readedFiles.Add(sqlFile);

                    }//foreach( var sqlFile in files)
                }//foreach(var sqlFolder in sqlFolders)

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



        public void WriteScriptSummary()
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(_dbName))
                    _sqlObjectWriter.WriteUseDb(_dbName);

                _sqlObjectWriter.WriteSqlScript(_sqlObjectList);
            }
            catch (Exception ex)
            {
                if (Output != null)
                    Output.WriteLine($"-- Error in {nameof(WriteSqlScript)}, {ex.Message}");
                else
                    Trace.TraceError($"-- Error in {nameof(WriteSqlScript)}, {ex.Message}");
            }
        }

        /// <summary>
        /// Deprecated, have to use WriteScriptSummary method
        /// </summary>
        public void WriteSqlScript()
        {
            WriteScriptSummary();
        }


        public void WriteScripts( Encoding encoding, string[] sqlSourceFiles)
        {
            WriteScripts(ScriptRootPath, encoding, sqlSourceFiles);
        }

        public void WriteScripts(string rootPath, Encoding encoding, string[] sqlSourceFiles)
        {
            foreach (var file in sqlSourceFiles)
            {
                try
                {
                    var filePath = Path.Combine(rootPath, file);

                    if (!File.Exists(filePath))
                    {
                        if (Output != null)
                            Output.WriteLine($"-- File not found '{filePath}'");
                        else
                            Trace.TraceError($"-- File not found '{filePath}'");
                        continue;
                    }

                    var filePathForPrint = filePath;
                    SqlObjectWriter.ClearFileName(SolutionPath, ref filePathForPrint);

                    _sqlObjectWriter.WriteLine("------------------------------------------------------------------------");
                    _sqlObjectWriter.WriteLine($"-- file {filePathForPrint}");

                    var lines = File.ReadAllLines(filePath, encoding);
                    foreach (var line in lines)
                    {
                        _sqlObjectWriter.WriteLine(line);
                    }

                    _sqlObjectWriter.WriteLine("------------------------------------------------------------------------");
                    _sqlObjectWriter.WriteLine("");
                }
                catch (Exception ex)
                {
                    if (Output != null)
                        Output.WriteLine($"-- Error in {nameof(WriteScripts)}, {ex.Message}");
                    else
                        Trace.TraceError($"-- Error in {nameof(WriteScripts)}, {ex.Message}");
                }
            }

        }


        public void ReplaceInBody(string pattern, string newStr)
        {
            try
            {
                foreach (var obj in _sqlObjectList)
                {
                    if (obj.ObjectBody.Contains(pattern))
                        obj.ObjectBody = obj.ObjectBody.Replace(pattern, newStr);
                }
            }
            catch (Exception ex)
            {
                if (Output != null)
                    Output.WriteLine($"-- Error in {nameof(WriteSqlScript)}, {ex.Message}");
                else
                    Trace.TraceError($"-- Error in {nameof(WriteSqlScript)}, {ex.Message}");
            }
        }

        #region IMergerForTest
        SqlObjectWriter IMergerForTest.SqlObjectWriter
        {
            get => _sqlObjectWriter;
            set => _sqlObjectWriter = value;
        }

        List<SqlObject> IMergerForTest.SqlObjectList
        {
            get => _sqlObjectList;
            set => _sqlObjectList = value;
        }

        SqlObjectParser IMergerForTest.Parser
        {
            get => _parser;
            set => _parser = value;
        }

        ISqlFileLoader IMergerForTest.SqlFileLoader
        {
            get => _sqlFileLoader;
            set => _sqlFileLoader = value;
        }
        #endregion
    }
}
