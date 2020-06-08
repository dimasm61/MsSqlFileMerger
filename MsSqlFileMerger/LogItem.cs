using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualStudio.TextTemplating;

namespace MsSqlFileMerger
{
    public class LogItem
    {
        public DateTime LogDatetime;

        public int TaskId;

        public string Msg;

        public override string ToString() => $"{TaskId:#00}/{Msg}";

        public static implicit operator LogItem(string s)
        {
            return new LogItem
            {
                LogDatetime = DateTime.Now,
                TaskId = Task.CurrentId ?? -1,
                Msg = s
            };
        }

        public static explicit operator string(LogItem counter) => counter.ToString();


        public static void WriteList(TextTransformation output, List<LogItem> logList)
        {
            var taskIdList = logList
                .GroupBy(c => c.TaskId)
                .Select(c => c.Key)
                .OrderBy(c=>c);

            foreach (var t in taskIdList)
            {
                var taskLog = logList.Where(c => c.TaskId == t);
                foreach (var s in taskLog)
                {
                    var msg = s.ToString();
                    if(output == null)
                        Trace.TraceInformation($"-- {msg}");
                    else
                        output.WriteLine($"-- {msg}");
                }
            }
        }
    }
}
