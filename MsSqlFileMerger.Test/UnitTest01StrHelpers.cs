using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MsSqlFileMerger.Test
{
    [TestClass]
    public class UnitTest01StrHelpers
    {
        [TestMethod]
        public void MatchEnds_Test1()
        {
            var charArr = new[]
            {
                " /*",
                " */",
                "*/ ",
                " */",
                " */",
                "-- ",
                " --",
                "?/*",
                "?*/",
                "*/?",
                "?*/",
                "?*/",
                "--?",
                "?--",
            };

            foreach (var s in charArr)
            {
                var k = s.Replace('?', 'g');
                Assert.AreEqual(k.ToCharArray().MatchEnds(s), true, $"{s} - {k}");
            }
        }

        [TestMethod]
        public void MatchEnds_Test2()
        {
            var charArr = new[]
            {
                " /*",
                " */",
                "*/ ",
                " */",
                " */",
                "-- ",
                " --",
                "?/*",
                "?*/",
                "*/?",
                "?*/",
                "?*/",
                "--?",
                "?--",
            };

            foreach (var s in charArr)
            {
                var k = s.Replace('?', 'g');

                if(k[0] != '?')
                    k = 'T'+ k.Remove(0,1);

                if (k[2] != '?')
                    k = k.Remove(2, 1) + 'T';
                Assert.AreNotEqual(k.ToCharArray().MatchEnds(s), true, $"{s} - {k}");
            }
        }


        [TestMethod]
        public void MatchEnds_Test3()
        {
            var charArr = new[]
            {
                " /*",
                " */",
                "*/ ",
                " */",
                " */",
                "-- ",
                " --",
                "?/*",
                "?*/",
                "*/?",
                "?*/",
                "?*/",
                "--?",
                "?--",
            };

            foreach (var s in charArr)
            {
                var k = s.Substring(1, 2);

                Assert.AreEqual(s.ToCharArray().MatchEnds(s), true, $"{s} - {k}");
            }
        }

        [TestMethod]
        public void MatchEnds_ContainsAny1()
        {
            var charArr = new[]
            {
                " /*",
                " */",
                "*/ ",
                " */",
                " */",
                "-- ",
                " --",
                "?/*",
                "?*/",
                "*/?",
                "?*/",
                "?*/",
                "--?",
                "?--",
            };

            foreach (var s in charArr)
            {
                var k = s.Replace('?', 'g');
                Assert.AreEqual(k.ToCharArray().ContainsAny(k[0], k[1], k[2]), true, $"{s} - {k}");
            }
        }

        [TestMethod]
        public void MatchEnds_ContainsAny2()
        {
            var charArr = new[]
            {
                " /*",
                " */",
                "*/ ",
                " */",
                " */",
                "-- ",
                " --",
                "?/*",
                "?*/",
                "*/?",
                "?*/",
                "?*/",
                "--?",
                "?--",
            };

            foreach (var s in charArr)
            {
                var k = "123";
                Assert.AreNotEqual(s.ToCharArray().ContainsAny(k[0], k[1], k[2]), true, $"[{s}] - [{k}]");
            }
        }

        [TestMethod]
        public void MatchEnds_Test4()
        {
        }

        [TestMethod]
        public void MatchEnds_Test5()
        {
        }

    }
}
