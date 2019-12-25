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

            var merger = new SqlFileMergeHelper();

            merger.Output = null;

            merger.Load(dbName, rootPath, Encoding.UTF8, sqlFolders, true);

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
    }
}
