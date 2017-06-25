using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Zebra.Models;

namespace Zebra.DAL
{
    public static class UserRepository
    {
        static List<User> users = new List<User>() {

        new User() {Name="Rishabh",Roles= "Admin,Editor", Password="b" },
        
        };

        public static User ValidateUser(User user)
        {
            return users.Where(u => u.Name.ToLower() == user.Name.ToLower() &&
            u.Password == user.Password).FirstOrDefault();
        }
    }
}