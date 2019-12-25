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
    internal class SqlObjectFileLoader
    {
        private SqlObjectParser _parser;

        public SqlObjectFileLoader(SqlObjectParser parser)
        {
            _parser = parser;
        }

        public List<SqlObject> LoadFile(TextTransformation output, string fileName, Encoding encoding, ref int createOrderCounter, bool isSpToEndFile)
        {
            var result = new List<SqlObject>();
            try
            {
                var txt = File.ReadAllLines(fileName, encoding);

                if (txt.Length > 0 && txt[0].StartsWith("T4_IGNORE"))
                    return new List<SqlObject>();

                result =  _parser.ParseStrArray(output, ref txt, ref createOrderCounter, fileName, isSpToEndFile);
            }
            catch (Exception ex)
            {
                if(output != null)
                    output.WriteLine($"-- catch error in {nameof(LoadFile)}, {ex.Message}");
                else
                {
                    Trace.TraceError($"-- catch error in {nameof(LoadFile)}, {ex.Message}");
                }
            }

            return result;

        }
    }
}
