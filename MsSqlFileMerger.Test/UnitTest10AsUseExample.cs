using System;
using System.IO;
using System.Text;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MsSqlFileMerger.Test
{
    [TestClass]
    public class UnitTest10AsUseExample
    {
        public string GetSolutionPath()
        {
            var solutionPath = "";

            if (Environment.CurrentDirectory.Contains("x86") || Environment.CurrentDirectory.Contains("x64"))
                solutionPath = Environment.CurrentDirectory + "\\..\\..\\..\\..";
            else
                solutionPath = Environment.CurrentDirectory + "\\..\\..\\..";

            return solutionPath;
        }

        [TestMethod]
        public void TestMethod1_Parallel()
        {

            var dbName = "TEST_LOG";

            var sqlFolders = new[]{
                "Folder01",
                "Folder02",
            };

            var excludeFiles = new[] { "02_View2.sql" };

            var merger = new SqlFileMergeHelper();

            merger.SetScriptRootFolder(GetSolutionPath(), @"\MsSqlFileMerger.Example\Sql");

            merger.Output = null;// result will be in trace output

            merger.LoadParallel(dbName, Encoding.UTF8, sqlFolders, true, "*.sql", excludeFiles, 2);

            merger.WriteSqlScript();
        }

        [TestMethod]
        public void TestMethod2()
        {
            var dbName = "TEST_LOG";

            var sqlFolders = new[]{
                 "Func",
                 "Sp",
            };

            var merger = new SqlFileMergeHelper();

            merger.SetScriptRootFolder(GetSolutionPath(), @"\MsSqlFileMerger.Test\");

            merger.Output = null;

            merger.LoadParallel(dbName, Encoding.UTF8, sqlFolders, false);

            merger.WriteSqlScript();
        }

        [TestMethod]
        public void TestMethod3()
        {

            var dbName = "VTSDB3_1";

            var sqlFolders = new[]{
                "Folder01",
                "Folder02",
            };


            var merger = new SqlFileMergeHelper();

            merger.SetScriptRootFolder(GetSolutionPath(), "\\MsSqlFileMerger.Example\\Sql");

            merger.Output = null;

            merger.IsWriteGenOrder = false;
            merger.IsWriteFileName = false;
            merger.RowDelimiterDropCreate = null;
            merger.RowDelimiterObject = "-- ∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙";

            merger.LoadParallel(dbName, Encoding.UTF8, sqlFolders, false, "*.sql", null, 1);


            // add version and date to sql proc body (by template)
            merger.ReplaceInBody("[version]", "ver:0.0.1.9");
            merger.ReplaceInBody("[date]", $"date:{DateTime.Now:dd.MM.yyyy}");

            // write generate date
            merger.Output?.WriteLine($"-- time {DateTime.Now:dd.MM.yyyy HH:mm}");
            merger.Output?.WriteLine("");

            merger.WriteSqlScript();
        }
    }
}
