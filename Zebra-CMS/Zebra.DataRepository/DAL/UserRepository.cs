using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.DAL
{
    public class UserRepository : BaseRepository<User>
    {
        private List<User> users = new DTOContextContainer().Users.ToList();

        public override List<User> GetByCondition(Expression<Func<User, bool>> selector)
        {
            throw new NotImplementedException();
        }

        public override User GetByName(User t)
        {
            return users.Where(u => u.UserName.ToLower().Equals(t.UserName.ToLower())).FirstOrDefault();
        }

        public override List<User> GetListById(IEntity t)
        {
            throw new NotImplementedException();
        }
    }
}