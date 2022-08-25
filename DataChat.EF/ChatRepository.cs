using Microsoft.EntityFrameworkCore;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DataChat.EF
{
    public class ChatRepository<T> : IRepository<T> where T : class
    {
        private readonly ChatContext _context;
        protected DbSet<T> DbSet;

        public ChatRepository(ChatContext context)
        {
            _context = context;
            context.Database.EnsureCreated();
            DbSet = _context.Set<T>();
        }

        public List<T> GetAll()
        {
            return DbSet.ToList();
        }

        public T Create(T entity)
        {
            var result = DbSet.Add(entity);
            _context.SaveChanges();
            return entity;
        }

        public void Update(T entity)
        {
            DbSet.Update(entity);
            _context.SaveChanges();
        }

        public void Remove(int id)
        {
            var entity = GetById(id);
            DbSet.Remove(entity);
            _context.SaveChanges();
        }

        public T GetById(int id)
        {
            return DbSet.Find(id);
        }
    }
}
