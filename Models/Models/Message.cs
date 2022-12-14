using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Message
    {
        public int Id { get; set; }
        public DateTime Date { get; set; }
        public string Text { get; set; }
        public int IdSender { get; set; }
        public int ChatId { get; set; }
        public bool IsVisible { get; set; }
        public bool WithAnswer { get; set; }
        public string AnswerText { get; set; }
        public bool Edited { get; set; }
    }
}
