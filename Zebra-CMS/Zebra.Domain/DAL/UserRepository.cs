using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Zebra.Domain.Models;

namespace Zebra.DAL
{
    public static class UserRepository
    {
        static List<Users> users = new DTOContext().Users.ToList();
        /*/    
        new List<Users>() {
        new Users() {UserName="Rishabh",Roles= "Admin,Editor", Password="b" },
        };
        /*/

        public static Users ValidateUser(Users user)
        {
            return users.Where(u => u.UserName.ToLower() == user.UserName.ToLower() &&
            u.Password == user.Password).FirstOrDefault();
        }
    }
}