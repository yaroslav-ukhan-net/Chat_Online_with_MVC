using Chat_MVC.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Models;
using Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Chat_MVC.Controllers
{
    public class ChatController : Controller
    {
        public const int  count_messages= 100;
        private readonly MessageService _MessageService;
        private readonly ChatService _ChatServise;

        public ChatController(MessageService userMessageService, ChatService chatService)
        {
            _MessageService = userMessageService;
            _ChatServise = chatService;
        }

        //Get
        [HttpGet]
        public IActionResult Chats(int id)
        {
            int PageNubmer, LastPageNubmer,IdSender, CountLastPage=20;
            bool ObjectForModel = false;
            if (Request.Cookies["PageNubmer"] == null || Request.Cookies["PageNubmer"] == "")
            {
                PageNubmer = 1;
            }
            else
            {
                PageNubmer = Convert.ToInt32(Request.Cookies["PageNubmer"]);
            }
            if (Request.Cookies["UserId"] == null)
            {
                IdSender = 5;
            }
            else
            {
                IdSender = Convert.ToInt32(Request.Cookies["UserId"]);
            }
            
            Chat NameSender = _ChatServise.GetById(IdSender);
            ViewData["NameSender"] = NameSender.Name; 
            ViewData["IdSender"] = IdSender;
            var Chat = _ChatServise.GetById(id);    
            var AllMessageInDB = _MessageService.GetMessages();
            var AllChats = _ChatServise.GetChats();
            if(Chat == null)
            {
                return BadRequest();
            }
            ChatMessageViewModel model = new ChatMessageViewModel();

            model.Id = id;
            model.IsGroup = Chat.IsGroup;
            model.Name = Chat.Name;
            model.Messages = new List<MessagesInChat>();
            model.AllChats = new List<AllChats>();
            

            List<MessagesInChat> AllMessangesForModel = new List<MessagesInChat>();
            foreach (var message in AllMessageInDB)
            {
                var name = _ChatServise.GetById(message.IdSender).Name;
                if (message.IsVisible == false && IdSender == message.IdSender) //скрытое смс
                {

                }
                else if (Chat.IsGroup && message.ChatId == id) //группа
                {
                    ObjectForModel = true;
                }
                else if (!Chat.IsGroup) //лс
                {
                    if (message.IdSender == IdSender && message.ChatId == id  && IdSender == id) //лс с собой
                    {
                        ObjectForModel = true;
                    }
                    else if((IdSender == message.ChatId && message.IdSender == id) || (message.IdSender == IdSender && message.ChatId == id)) //лс с другом
                    {
                        ObjectForModel = true;
                    }
                }
                if (ObjectForModel)
                {
                    AllMessangesForModel.Add(new MessagesInChat()
                    {
                        Id = message.Id,
                        Date = message.Date,
                        IdSender = message.IdSender,
                        IsVisible = message.IsVisible,
                        Text = message.Text,
                        Name = name,
                        WithAnswer = message.WithAnswer,
                        AnswerText = message.AnswerText,
                        Edited = message.Edited
                    });
                    ObjectForModel = false;
                }
            }

            LastPageNubmer = AllMessangesForModel.Count / 20;
            if (!(AllMessangesForModel.Count / 20 == 0)) //кол-во смс кратное 20
            {
                LastPageNubmer = (AllMessangesForModel.Count / 20)+1;
            }

            if(AllMessangesForModel.Count < 20) //Единственная страничка в чате?
            {
                CountLastPage = AllMessangesForModel.Count % 20;
            }


            if (PageNubmer > LastPageNubmer) //выход за предел чата
            {
                PageNubmer = LastPageNubmer;
            }
            else if (PageNubmer < 1) //выход за предел чата
            {
                PageNubmer = 1;
            }


            if (PageNubmer == LastPageNubmer || LastPageNubmer ==0) //Последняя страничка
            {
                for (int i = 0; i < CountLastPage; i++)
                {
                    model.Messages.Add(AllMessangesForModel[i]);
                }
            }
            else //любая страничка, отбор 20 обьектов
            {
                for (int i = AllMessangesForModel.Count - (PageNubmer * 20); model.Messages.Count < 20; i++)
                {
                    model.Messages.Add(AllMessangesForModel[i]);
                }
            }


            
            model.pageNubmer = PageNubmer;
            Response.Cookies.Append("PageNubmer", "");

            foreach (var chat in AllChats) //Добавление чатов
            {
                model.AllChats.Add(new ViewModels.AllChats() { Id = chat.Id, Name = chat.Name , IsGroup = chat.IsGroup});
            }
            if (Request.Cookies["AnswerMessageId"] != "" && Request.Cookies["AnswerMessageId"] != null) //Хранение смс для ответа
            {
                model.message = new Message() 
                { ChatId = id, 
                  IdSender = IdSender, 
                  IsVisible = true, 
                  WithAnswer = true, 
                  AnswerText = _ChatServise.GetById(_MessageService.GetById(Convert.ToInt32(Request.Cookies["AnswerMessageId"])).IdSender).Name.ToString() + ":"+ _MessageService.GetById(Convert.ToInt32(Request.Cookies["AnswerMessageId"])).Text};
            }
            else if (Request.Cookies["EditMessageId"] != "" && Request.Cookies["EditMessageId"] != null) //Хранение смс для редактирования
            {
                model.message = new Message()
                {
                    ChatId = id,
                    IdSender = IdSender,
                    IsVisible = true,
                    WithAnswer = _MessageService.GetById(Convert.ToInt32(Request.Cookies["EditMessageId"])).WithAnswer,
                    Text = _MessageService.GetById(Convert.ToInt32(Request.Cookies["EditMessageId"])).Text,
                    Edited = _MessageService.GetById(Convert.ToInt32(Request.Cookies["EditMessageId"])).Edited,
                    Id = _MessageService.GetById(Convert.ToInt32(Request.Cookies["EditMessageId"])).Id
                };
            }
            else
            {
                model.message = new Message() { ChatId = id, IdSender = IdSender, IsVisible = true};
            }
            Response.Cookies.Append("AnswerMessageId", "");
            Response.Cookies.Append("EditMessageId", "");
            return View(model);

        }
        //Get
        [HttpPost]
        public IActionResult Send(ChatMessageViewModel mes)
        {
            if (mes.message.Text == null)
            {
                return RedirectToAction("Chats", new { id = mes.message.ChatId });
            }

            if (mes.message.Id != 0)
            {
                if (mes.message.Text != _MessageService.GetById(mes.message.Id).Text)
                {
                    Message message = _MessageService.GetById(mes.message.Id);
                    message.Edited = true;
                    message.Text = mes.message.Text;
                    _MessageService.UpdateMessage(message);
                }
            }
            else
            {
                mes.message.Date = DateTime.Now;
                _MessageService.CreateMessage(ToModel(mes));
            }

            
            return RedirectToAction("Chats", new { id = mes.message.ChatId });
        }

        [HttpGet]
        public IActionResult DeleteAll(int IdChat, int Id)
        {
            _MessageService.DeleteMessage(Id);
            return RedirectToAction("Chats", new { id = IdChat });
        }

        [HttpGet]
        public IActionResult DeleteMe(int IdChat, int Id)
        {
            Message mes = _MessageService.GetById(Id);
            mes.IsVisible = false;
            _MessageService.UpdateMessage(mes);
            return RedirectToAction("Chats", new { id = IdChat });
        }
        [HttpGet]
        public IActionResult Edit(int IdChat, int Id)
        {
            Response.Cookies.Append("EditMessageId", Id.ToString());
            return RedirectToAction("Chats", new { id = IdChat });
        }
        [HttpGet]
        public IActionResult Answer_for_message(int IdChat, int Id)
        {
            Response.Cookies.Append("AnswerMessageId", Id.ToString());
            return RedirectToAction("Chats", new { id = IdChat });

        }

        [HttpGet]
        public IActionResult ChooseUser(int IdChat, int IdUser)
        {
            Response.Cookies.Append("UserId", IdUser.ToString());
            return RedirectToAction("Chats", new { id = IdChat });
        }
        [HttpGet]
        public IActionResult PageNubmer(int IdChat, int Number)
        {
            Response.Cookies.Append("PageNubmer", Number.ToString());
            return RedirectToAction("Chats", new { id = IdChat });
        }

        private Message ToModel(ChatMessageViewModel viewModel)
        {
            return new Message()
            {
                ChatId = viewModel.message.ChatId,
                Date = viewModel.message.Date,
                IdSender = viewModel.message.IdSender,
                IsVisible = viewModel.message.IsVisible,
                Text = viewModel.message.Text,
                WithAnswer = viewModel.message.WithAnswer,
                AnswerText = viewModel.message.AnswerText,
                Edited = viewModel.message.Edited
            };
        }
    }
}
