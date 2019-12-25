using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MsSqlFileMerger.Test
{
    [TestClass]
    public class UnitTest03ScriptParser
    {
        private static ConsoleWriter _writer;

        private static List<SqlObject> _objList = new List<SqlObject>();

        [ClassInitialize]
        public static void TestInit(TestContext ctx)
        {
            _writer = new ConsoleWriter();

            _writer.WriteEvent += writer_WriteEvent;
            _writer.WriteLineEvent += writer_WriteLineEvent;

            Console.SetOut(_writer);

        }

        static void writer_WriteLineEvent(object sender, ConsoleWriterEventArgs e)
        {
            var s = e.Value;

            // if (s.Contains("create"))
            // {
            //     var newObj = new SqlObject();
            //     newObj.ObjectType = SqlObjectTypeEnum.StoredProc;
            //     newObj.ParseName(s);
            //     newObj.CreateOrder = createOrderCounter++;
            //     newObj.SqlSourceFile = sqlSourceFile;
            //     _sqlObjectList.Add(newObj);
            // }
            Trace.WriteLine(e.Value);
        }

        static void writer_WriteEvent(object sender, ConsoleWriterEventArgs e)
        {
            Trace.Write(e.Value);
        }

        [TestMethod]
        public void TestMethod_Funcs()
        {
            var solutionsPath = @"M:\github_dimasm61\MsSqlFileMerger\";
            var rootPath = $"{solutionsPath}\\MsSqlFileMerger.Test\\Test";
            var fileName = $"{rootPath}\\test_func.sql";

            ParseAndWriteFile(fileName);

        }

        [TestMethod]
        public void TestMethod_Views()
        {
            var solutionsPath = @"M:\github_dimasm61\MsSqlFileMerger\";
            var rootPath = $"{solutionsPath}\\MsSqlFileMerger.Test\\Test";
            var fileName = $"{rootPath}\\test_view.sql";

            ParseAndWriteFile(fileName);
        }

        [TestMethod]
        public void TestMethod_Proc()
        {
            var solutionsPath = @"M:\github_dimasm61\MsSqlFileMerger\";
            var rootPath = $"{solutionsPath}\\MsSqlFileMerger.Test\\Test";
            var fileName = $"{rootPath}\\test_proc.sql";

            ParseAndWriteFile(fileName);
        }

        [TestMethod]
        public void TestMethod_Table()
        {
            var solutionsPath = @"M:\github_dimasm61\MsSqlFileMerger\";
            var rootPath = $"{solutionsPath}\\MsSqlFileMerger.Test\\Test";
            var fileName = $"{rootPath}\\test_table.sql";

            ParseAndWriteFile(fileName);
        }

        [TestMethod]
        public void TestMethod_ProcNoToEndFile()
        {
            var solutionsPath = @"M:\github_dimasm61\MsSqlFileMerger\";
            var rootPath = $"{solutionsPath}\\MsSqlFileMerger.Test\\Sp";
            var fileName = $"{rootPath}\\00_atm.CrossLineBorder.sql";

            ParseAndWriteFile(fileName, false);
        }

        [TestMethod]
        public void TestMethod_ViewNoToEndFile()
        {
            var solutionsPath = @"M:\github_dimasm61\MsSqlFileMerger\";
            var rootPath = $"{solutionsPath}\\MsSqlFileMerger.Test\\View";
            var fileName = $"{rootPath}\\nsi.vPort.sql";

            ParseAndWriteFile(fileName, false);
        }

        private void ParseAndWriteFile(string fileName, bool isToEndFile = true)
        {
            var writer = new SqlObjectWriter();
            var sqlObjectList = new List<SqlObject>();
            var parser = new SqlObjectParser();

            var txt = File.ReadAllLines(fileName, Encoding.UTF8);
            var list = new List<string>();
            var createOrderCounter = 1;
            var parsedObjectCounter = 0;
            var objectInFileCounter = 0;
            foreach (var s in txt)
            {
                if (string.IsNullOrWhiteSpace(s))
                    continue;
                if (s.StartsWith("-----"))
                {


                    var arr = list.ToArray();
                    var parsedObjects = parser.ParseStrArray(null, ref arr, ref createOrderCounter, $"fileTest{createOrderCounter}", isToEndFile);

                    if (parsedObjects.Any()) objectInFileCounter++;

                    foreach (var parsedObject in parsedObjects)
                    {
                        parsedObjectCounter++;
                        sqlObjectList.Add(parsedObject);
                    }

                    list.Clear();
                }
                else
                {
                    list.Add(s);
                }
            }

            if (list.Any())
            {
                var arr = list.ToArray();
                var parsedObjects = parser.ParseStrArray(null, ref arr, ref createOrderCounter, $"fileTest{createOrderCounter}", isToEndFile);

                if (parsedObjects.Any()) objectInFileCounter++;

                foreach (var parsedObject in parsedObjects)
                {
                    parsedObjectCounter++;
                    sqlObjectList.Add(parsedObject);
                }
            }




            writer.WriteSqlScript(sqlObjectList);

            Assert.AreEqual(parsedObjectCounter, objectInFileCounter, "Не совпало количество объектов в файле и того что получилось в результате");

        }
    }
}
