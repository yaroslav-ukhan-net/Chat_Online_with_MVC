using Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Chat_MVC.ViewModels
{
    public class ChatMessageViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public bool IsGroup { get; set; }
        public List<MessagesInChat> Messages { get; set; }
        public List<AllChats> AllChats { get; set; }
        public Message message {get;set;}
        public int pageNubmer { get; set; }
    }

    public class AllChats
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public bool IsGroup { get; set; }
    }

    public class MessagesInChat
    {
        public int Id { get; set; }
        public DateTime Date { get; set; }

        public string Text { get; set; }
        public int IdSender { get; set; }
        public bool IsVisible { get; set; }
        public string Name { get; set; }
        public bool WithAnswer { get; set; }
        public string AnswerText { get; set; }
        public bool Edited { get; set; }
    }
}
