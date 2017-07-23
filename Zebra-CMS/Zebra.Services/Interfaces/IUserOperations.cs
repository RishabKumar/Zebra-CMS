using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;

namespace Zebra.Services.Interfaces
{
    public interface IUserOperations
    {

        User CreateUser(string username, string password, string roles);

        User ValidateUser(User users); 


    }
}
