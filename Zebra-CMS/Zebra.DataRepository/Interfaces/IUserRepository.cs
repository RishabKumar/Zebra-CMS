using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.Interfaces
{
    public interface IUserRepository
    {
        User CreateUser(User user);
        User DeleteUser(User user);
        User UpdateUser(User user);

        Role CreateRole(Role role);
        Role DeleteRole(Role role);
        Role UpdateRole(Role role);

        void AssignRole(User user, Role role);
        void RemoveRole(User user, Role role);

        void AddOrUpdatePermission(Node node, Role role, bool nonreadable, bool nonwritable);

        NodeRoleMap GetNodeRoleMap(Node node, Role role);
        RoleUserMap GetRoleUserMap(Role role, User user);
        List<Role> GetRolesOfUser(User user);
        List<Role> GetAllRoles();
        List<User> GetAllUsers();

        Role GetRole(Role role);
        User GetUser(User user);
    }
}
