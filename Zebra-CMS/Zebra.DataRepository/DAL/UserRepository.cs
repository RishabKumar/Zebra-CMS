using System.Collections.Generic;
using System.Linq;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.DAL
{
    public class UserRepository : BaseRepository<Users>
    {
        private List<Users> users = new DTOContextContainer().Users.ToList();

        public override Users GetById(Users t)
        {
            return users.Where(u => u.UserId.Equals(t.UserId)).FirstOrDefault();
        }

        public override Users GetByName(Users t)
        {
            return users.Where(u => u.UserName.ToLower().Equals(t.UserName.ToLower())).FirstOrDefault();
        }
    }
}