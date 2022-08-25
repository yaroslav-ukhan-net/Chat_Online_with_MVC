using Models;
using System;
using System.Collections.Generic;

namespace Services
{
    public class ChatService
    {
        private readonly IRepository<Chat> _ChatRepository;

        public ChatService()
        {

        }
        public ChatService(IRepository<Chat> repository)
        {
            _ChatRepository = repository;
        }
        public virtual List<Chat> GetChats()
        {
            return _ChatRepository.GetAll();
        }
        public virtual void DeleteChats(int id)
        {
            var gropupmessage = _ChatRepository.GetById(id);
            if(gropupmessage == null)
            {
                throw new ArgumentException($"Cannot find chat with id '{id}'");
            }
            _ChatRepository.Remove(id);
        }
        public virtual void UpdateChat(Chat chat)
        {
            _ChatRepository.Update(chat);
        }

        public virtual Chat GreateChat (Chat chat)
        {
            return _ChatRepository.Create(chat);
        }
        public virtual Chat GetById(int id)
        {
            return _ChatRepository.GetById(id);
        }
    }
}
