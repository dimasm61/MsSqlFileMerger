using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualStudio.TextTemplating;

namespace MsSqlFileMerger
{
    internal class SqlObjectFileLoader: ISqlFileLoader
    {
        public bool IsTraceIfFindIgnoreKeyword { get; set; } = false;

        private SqlObjectParser _parser;

        public void Init(SqlObjectParser parser)
        {
            _parser = parser;
        }

        public List<SqlObject> LoadFile(
            string solutionPath
            , string fileName
            , Encoding encoding
            , ref int createOrderCounter
            , bool isSpToEndFile
            , List<LogItem> outputList)
        {
            var result = new List<SqlObject>();
            try
            {
                // load file with encoding
                var txt = File.ReadAllLines(fileName, encoding);

                if (txt.Length > 0 && txt[0].Contains("T4_IGNORE"))
                {
                    if (IsTraceIfFindIgnoreKeyword)
                    {
                        SqlObjectWriter.ClearFileName(solutionPath, ref fileName);
                        outputList.Add($"find T4_IGNORE keyword in file {fileName}");
                        outputList.Add($"file will be ignored");
                    }

                    return new List<SqlObject>();
                }

                // parsing text to list of sql object
                result =  _parser.ParseStrArray(/*output, */ref txt, ref createOrderCounter, fileName, isSpToEndFile, outputList);
            }
            catch (Exception ex)
            {
                //Trace.TraceError($"-- catch error in {nameof(LoadFile)}, {ex.Message}");
                outputList.Add($"catch error in {nameof(LoadFile)}, {ex.Message}");
                outputList.Add($"catch error in {nameof(LoadFile)}, {ex.StackTrace}");
            }

            return result;

        }
    }
}
