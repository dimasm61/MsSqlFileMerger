using System;
using System.Text;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MsSqlFileMerger.Test
{
    [TestClass]
    public class UnitTest10AsUseExample
    {
        [TestMethod]
        public void TestMethod1()
        {

            var rootPath = @"M:\github_dimasm61\MsSqlFileMerger\MsSqlFileMerger.Example\Sql";

            var dbName = "TEST_LOG";

            var sqlFolders = new[]{
                "Folder01",
                "Folder02",
            };

            var excludeFiles = new[] { "02_View2.sql" };

            var merger = new SqlFileMergeHelper();

            merger.Output = null;

            merger.Load(dbName, rootPath, Encoding.UTF8, sqlFolders, true, "*.sql", excludeFiles);

            merger.WriteSqlScript();
        }

        [TestMethod]
        public void TestMethod2()
        {

            var rootPath = @"M:\mcs_2019\trunk\\02_Sql\VtsDb3\";

            var dbName = "TEST_LOG";

            var sqlFolders = new[]{
                 "Nsi",
                 "PassView",
                 "Pilot",
                 "Plan",
                 "Request",
                 "NavSign",
                 "Scan",
                 "Snr",
                 "User",
                 "Contact",
                 "Automation\\Func",
                 "Automation\\Views",
                 "Automation\\Sp",
                "PassSp",
            };

            var merger = new SqlFileMergeHelper();

            merger.Output = null;

            merger.Load(dbName, rootPath, Encoding.UTF8, sqlFolders, false);

            merger.WriteSqlScript();
        }

        [TestMethod]
        public void TestMethod3()
        {

            var rootPath = @"M:\github_dimasm61\sqlnotify2log\SqlNotify2LogVs\\Sql";

            var dbName = "VTSDB3_1";

            var sqlFolders = new[]{
                "01_DB_LOG_Tables_and_Sequences",
            };


            var merger = new SqlFileMergeHelper();

            merger.Output = null;

            merger.Load(dbName, rootPath, Encoding.UTF8, sqlFolders, false);

            merger.WriteSqlScript();
        }
    }
}
