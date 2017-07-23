using System;
using System.Collections.Generic;
using System.Linq;
using Zebra.DataRepository.DAL;
using Zebra.DataRepository.Models;
using Zebra.Services.Interfaces;

namespace Zebra.Services.Operations
{
    public class UserOperations : BaseOperations<UserRepository, User>, IUserOperations
    {
        public UserOperations(UserRepository t) : base(t)
        {
        }

        public User CreateUser(string username, string password, string roles)
        {
            throw new NotImplementedException();
        }

        public User ValidateUser(User user)
        {
            List<User> list = _base.GetAll();
            return list.Where(u => u.UserName.ToLower() == user.UserName.ToLower() &&
            u.Password == user.Password).FirstOrDefault();
        }
    }
}
