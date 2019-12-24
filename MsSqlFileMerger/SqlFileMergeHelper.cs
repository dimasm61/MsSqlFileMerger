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
    public class SqlFileMergeHelper
    {
        private string _dbName = "";
        private SqlObjectWriter _sqlObjectWriter;
        private List<SqlObject> _sqlObjectList;
        private SqlObjectParser _parser;
        private SqlObjectFileLoader _sqlFileLoader;

        public TextTransformation Output
        {
            get => _sqlObjectWriter.Output;
            set => _sqlObjectWriter.Output = value;
        }


        public SqlFileMergeHelper()
        {
            _sqlObjectList = new List<SqlObject>();
            _sqlObjectWriter = new SqlObjectWriter();
            _sqlObjectList = new List<SqlObject>();
            _parser = new SqlObjectParser();
            _sqlFileLoader = new SqlObjectFileLoader(_parser);
        }

        public void Load(string dbName, string rootPath, Encoding encoding, string[] sqlFolders, bool isSpToEndFile)
        {
            _dbName = dbName;

            _sqlObjectList.Clear();

            var readedFiles = new List<string>();

            var createOrderCounter = 0;
            
            foreach (var sqlFolder in sqlFolders)
            {
                var folder = Path.Combine(rootPath, sqlFolder);
                var files = Directory.GetFiles(folder, "*.sql", SearchOption.TopDirectoryOnly);
                foreach (var sqlFile in files)
                {
                    // WriteLine($"-- {sqlFile}");

                    if (!string.IsNullOrEmpty(sqlFile) && sqlFile.ToLower().Contains("ignore"))
                        continue;

                    var parsedObjects = _sqlFileLoader.LoadFile(sqlFile, encoding, ref createOrderCounter, isSpToEndFile);

                    foreach (var parsedObject in parsedObjects)
                    {
                        _sqlObjectList.Add(parsedObject);
                    }

                    readedFiles.Add(sqlFile);

                }//foreach( var sqlFile in files)
            }//foreach(var sqlFolder in sqlFolders)


        }


        public void WriteSqlScript()
        {
            if(!string.IsNullOrWhiteSpace(_dbName))
                _sqlObjectWriter.WriteUseDb(_dbName);

            _sqlObjectWriter.WriteSqlScript(_sqlObjectList);
        }

    }
}
