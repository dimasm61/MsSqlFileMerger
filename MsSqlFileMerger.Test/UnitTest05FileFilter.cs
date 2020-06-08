using System;
using System.Text;
using System.Collections.Generic;
using System.IO;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.VisualStudio.TextTemplating;

namespace MsSqlFileMerger.Test
{
    /// <summary>
    /// Summary description for UnitTest05FileFilter
    /// </summary>
    [TestClass]
    public class UnitTest05FileFilter
    {
        public UnitTest05FileFilter()
        {
        }


        [TestMethod]
        public void TestMethod1()
        {
            var loader = new Loader();

            IMerger merger = new SqlFileMergeHelper();
            ((IMergerForTest)merger).SqlFileLoader = loader;

            var solutionsPath = @"M:\github_dimasm61\MsSqlFileMerger\";
            var rootPath = $"{solutionsPath}\\MsSqlFileMerger.Test";

            var sqlFolders = new[]{
                "Test",
            };

            var excludeFiles = new[] { "test_table.sql" };

            merger.Load("testDb", rootPath, Encoding.UTF8, sqlFolders, true, "*.sql", excludeFiles);

            Assert.AreEqual(loader.fileNameList.Count,3);
            Assert.AreEqual(loader.fileNameList.Contains(excludeFiles[0]),false);

        }

        internal class Loader : ISqlFileLoader
        {
            public List<string> fileNameList = new List<string>();
            public bool IsTraceIfFindIgnoreKeyword { get; set; }

            public List<SqlObject> LoadFile(string solutionPath, string fileName, Encoding encoding, ref int createOrderCounter,
                bool isSpToEndFile, List<LogItem> outputList)
            {
                var file = Path.GetFileName(fileName);
                fileNameList.Add(fileName);
                return new List<SqlObject>();
            }

            public void Init(SqlObjectParser parser)
            {
                throw new NotImplementedException();
            }
        }
    }
}
