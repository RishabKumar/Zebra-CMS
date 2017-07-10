using System;
using System.Collections.Generic;
using System.Linq;
using Zebra.DataRepository.DAL;
using Zebra.DataRepository.Models;
using Zebra.Services.Interfaces;

namespace Zebra.Services.Operations
{
    public class UserOperations : IUserOperations
    {
        BaseRepository<Users> _base;

        public UserOperations(UserRepository userrepo)
        {
            _base = userrepo;
        }

        public Users CreateUser(string username, string password, string roles)
        {
            throw new NotImplementedException();
        }

        public Users ValidateUser(Users user)
        {
            List<Users> list = _base.GetAll();
            return list.Where(u => u.UserName.ToLower() == user.UserName.ToLower() &&
            u.Password == user.Password).FirstOrDefault();
        }
    }
}
