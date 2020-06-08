using System;
using System.Collections.Generic;
using System.Diagnostics;
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


        [TestMethod]
        public void TestMethod4()
        {
            var sw = Stopwatch.StartNew();


            var dbName = "";

            // подпапки проекта в которых нужные файлы 
            var sqlFolders = new[]{
            "App",
            "Nsi",
            "Permit",
            "Plan",
            "Pass\\View",
            "Request",
            "NavSign",
            "Scan",
            "Snr",
            "User",
            "Contact",
            "Caravan",
            "Automation\\Func",
            "Automation\\Views",
            "Automation\\Sp",
            "Pass\\Sp",
            "Pilot",
            "Weather",
            "Caravan",
            "Rep\\Actual"
            };

            // обновление таблиц
            var scriptsBefore = new List<string>();

            var newVersion = "0.0.16.0";

            switch (newVersion)
            {
                case "0.0.16.0":
                    //scriptsBefore.Add(@"@Update\00.00.16.00\00.00.16.00_ZSA_UpdateBefore.sql");
                    scriptsBefore.Add(@"@Update\00.00.16.00\00.00.16.00_MDO_UpdateBefore.sql");
                    break;
                case "0.0.15.0":
                    scriptsBefore.Add(@"@Update\00.00.15.00\00.00.15.00_MDO_UpdateBefore.sql");
                    break;
                case "0.0.14.0":
                    scriptsBefore.Add(@"@Update\00.00.14.00\00.00.14.00_ZSA_UpdateBefore.sql");
                    scriptsBefore.Add(@"@Update\00.00.14.00\00.00.14.00_YDV_UpdateBefore.sql");
                    scriptsBefore.Add(@"@Tables\PassBunch.sql");
                    scriptsBefore.Add(@"@Tables\PassDelay.sql");
                    break;
                case "0.0.13.0":
                    scriptsBefore.Add(@"@Update\00.00.13.00\00.00.13.00_ZSA_UpdateBefore.sql");
                    scriptsBefore.Add(@"@Update\00.00.13.00\00.00.13.00_YDV_UpdateBefore.sql");
                    scriptsBefore.Add(@"@Update\00.00.13.00\00.00.13.00_PSA_UpdateBefore.sql");
                    break;
                case "0.0.12.0":
                    scriptsBefore.Add(@"@Update\00.00.12.00\00.00.12.00_MDO_UpdateBefore.sql");
                    break;
                case "0.0.10.0":
                    scriptsBefore.Add(@"@Tables\PassReceiptDeleted.sql");
                    scriptsBefore.Add(@"@Tables\ServerSett.sql");
                    scriptsBefore.Add(@"@Tables\ServerWorkTime.sql");
                    scriptsBefore.Add(@"@Update\00.00.10.00_UpdateBefore.sql");
                    break;

            }

            // компонент который может мержить эти файлы 
            var merger = new SqlFileMergeHelper();

            merger.SetScriptRootFolder("M:\\mcs_2019\\trunk", "02_Sql\\VtsDb3");
            merger.Output = null;
            merger.IsTraceIfFindIgnoreKeyword = true;

            // загружаем
            merger.LoadParallel(null, Encoding.Default, sqlFolders, false, null, null, 6);

            sw.Stop();
            merger.Output?.WriteLine($"-- парсинг скриптов: {sw.Elapsed.TotalSeconds:#0.000} сек");

            // обновление струткруты таблиц до новых вьюх и хп
            merger.WriteScripts(Encoding.UTF8, scriptsBefore.ToArray());

            // пишем итоговый скрипт
            merger.WriteScriptSummary();

            // проставляем версию в БД
            merger.Output?.WriteLine($"exec app.spServerSettSet 'version', '{newVersion}'");
        }
    }
}
