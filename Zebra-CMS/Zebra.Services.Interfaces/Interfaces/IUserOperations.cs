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

        User CreateUser(string userName, string password);

        void DeleteUser(string userid);
        Role CreateRole(string roleName);

        void AddOrUpdatePermissions(string roleid, string nodeid, bool readable, bool writable);
        void AssignRole(string userid, string roleid);

        List<Role> GetAllRoles();
        List<User> GetAllUsers();



        User ValidateUser(User users);

        Role GetRole(string roleid);
        User Getuser(string userid);
        NodeRoleMap GetNodeRoleMap(string nodeid, string roleid);


        Node FilterByRole(string roleid, Node node);
        Node FilterByUser(User user, Node node);
        Node FilterByUser(string userid, Node node);
        IEnumerable<Node> FilterByRole(string roleid, IEnumerable<Node> nodes);
        IEnumerable<Node> FilterByUser(User user, IEnumerable<Node> nodes);
        IEnumerable<Node> FilterByUser(string userid, IEnumerable<Node> nodes);
    }
}
