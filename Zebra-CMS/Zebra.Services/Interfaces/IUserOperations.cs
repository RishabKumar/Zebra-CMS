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

        Users CreateUser(string username, string password, string roles);

        Users ValidateUser(Users users); 


    }
}
