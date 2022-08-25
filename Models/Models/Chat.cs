using System;
using System.Collections.Generic;

namespace Models
{
    public class Chat
    {
        public int Id { get; set; }
        public string Name {get;set;}
        public bool IsGroup { get; set; }
        public virtual List<Message> Messages { get; set; } = new List<Message>();
    }
}
