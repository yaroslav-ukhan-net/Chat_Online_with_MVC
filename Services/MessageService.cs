using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services
{
    public class MessageService
    {
        private readonly IRepository<Message> _messageRepository;
        public MessageService()
        {

        }
        public MessageService(IRepository<Message> MessageRepository)
        {
            _messageRepository = MessageRepository;
        }
        public virtual List<Message> GetMessages()
        {
            return _messageRepository.GetAll();
        }
        public virtual void DeleteMessage(int id)
        {
            var usermessage = _messageRepository.GetById(id);
            if(usermessage == null)
            {
                throw new ArgumentException($"Cannot find message with id '{id}'");
            }
            _messageRepository.Remove(id);
        }
        public virtual void UpdateMessage(Message message)
        {
            _messageRepository.Update(message);
        }

        public virtual Message CreateMessage(Message Message)
        {
            var newMessage = _messageRepository.Create(Message);
            return newMessage;
        }
        public virtual Message GetById(int id)
        {
            return _messageRepository.GetById(id);
        }
    }
}
