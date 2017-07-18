using System.Collections.Generic;
using System.Linq;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.DAL
{
    public class UserRepository : BaseRepository<User>
    {
        private List<User> users = new DTOContextContainer().Users.ToList();

        public override User GetByName(User t)
        {
            return users.Where(u => u.UserName.ToLower().Equals(t.UserName.ToLower())).FirstOrDefault();
        }
    }
}