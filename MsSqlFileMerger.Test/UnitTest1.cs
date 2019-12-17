using System;
using System.IO;
using System.Reflection;
using System.Text;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MsSqlFileMerger;

namespace MsSqlFileMerger.Test
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestMethod1()
        {
            string solutionsPath = @"M:\github_dimasm61\MsSqlFileMerger\";

            //string solutionsPath = Directory.GetParent(Directory.GetCurrentDirectory()).Parent.FullName;

            // var solutionsPath =
            //     Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location.Replace("bin\\Debug", string.Empty));

            var rootPath = $"{solutionsPath}\\MsSqlFileMerger.Test";

            var dbName = "TEST_LOG";

            var sqlFolders = new[]{
                "Func",

            };

            var merger = new SqlFileMergeHelper();

            merger.Load(dbName, rootPath, Encoding.GetEncoding(1251), sqlFolders, false);

            merger.WriteSqlScript();
        }

        [TestMethod]
        public void TestMethod2()
        {

            // string solutionsPath = @"M:\github_dimasm61\MsSqlFileMerger\";
            // 
            // var rootPath = @"M:\mcs_2019\trunk\02_Sql\Vtsdb3\Automation\";
            // 
            // var dbName = "TEST_LOG";
            // 
            // var sqlFolders = new[]{
            //     "Views",
            // 
            // };
            // 
            // var merger = new SqlFileMergeHelper();
            // 
            // merger.Load(dbName, rootPath, Encoding.UTF8, sqlFolders, false);
            // 
            // merger.WriteSqlScript();
        }
    }
}
