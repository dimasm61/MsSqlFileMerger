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
    public class SqlFileMergeHelper: IMerger, IMergerForTest
    {
        private string _dbName = "";
        private SqlObjectWriter _sqlObjectWriter;
        private List<SqlObject> _sqlObjectList;
        private SqlObjectParser _parser;
        private /*SqlObjectFileLoader*/ISqlFileLoader _sqlFileLoader;


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

                var createOrderCounter = 0;

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

                        var parsedObjects = _sqlFileLoader.LoadFile(Output, sqlFile, encoding, ref createOrderCounter, isSpToEndFile);

                        foreach (var parsedObject in parsedObjects)
                        {
                            _sqlObjectList.Add(parsedObject);
                        }

                        readedFiles.Add(sqlFile);

                    }//foreach( var sqlFile in files)
                }//foreach(var sqlFolder in sqlFolders)
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

        public void WriteSqlScript()
        {
            WriteScriptSummary();
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

                    _sqlObjectWriter.WriteLine("------------------------------------------------------------------------");
                    _sqlObjectWriter.WriteLine($"-- file {filePath}");

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
