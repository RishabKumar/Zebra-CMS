using System;
using System.Collections.Generic;
using System.Linq;
using Zebra.DataRepository.DAL;
using Zebra.DataRepository.Interfaces;
using Zebra.DataRepository.Models;
using Zebra.Services.Interfaces;

namespace Zebra.Services.Operations
{
    public class UserOperations : BaseOperations<UserRepository, User>, IUserOperations
    {
        IUserRepository _userrepo;
        public UserOperations(UserRepository t) : base(t)
        {
            _userrepo = t;
        }

        public void AddOrUpdatePermissions(string roleid, string nodeid, bool readable, bool writable)
        {
            var role = GetRole(roleid);
            var node = OperationsFactory.NodeOperations.GetNode(nodeid);
            _userrepo.AddOrUpdatePermission(node, role, !readable, !writable);
        }

        public Role CreateRole(string roleName)
        {
            var role = new Role() { Id = Guid.NewGuid(), RoleName = roleName };
            return _userrepo.CreateRole(role);
        }

        public User CreateUser(string userName, string password)
        {
            var user = new User() { Id = Guid.NewGuid(), Password = password, UserName = userName };
            return _userrepo.CreateUser(user);
        }

        public User CreateUser(string username, string password, string roles)
        {
            throw new NotImplementedException();
        }

        public List<Role> GetAllRoles()
        {
            return _userrepo.GetAllRoles();
        }

        public List<User> GetAllUsers()
        {
            return _userrepo.GetAllUsers();
        }

        public User ValidateUser(User user)
        {
            List<User> list = GetAllUsers();
            return list.Where(u => u.UserName.ToLower() == user.UserName.ToLower() &&
            u.Password == user.Password).FirstOrDefault();
        }

        public NodeRoleMap GetNodeRoleMap(string nodeid, string roleid)
        {
            return _userrepo.GetNodeRoleMap(OperationsFactory.NodeOperations.GetNode(nodeid), GetRole(roleid));
        }

        public Role GetRole(string roleid)
        {
            if (string.IsNullOrWhiteSpace(roleid))
            {
                return null;
            }
            var Id = new Guid(roleid);
            if (Guid.Empty.Equals(Id))
            {
                return null;
            }
            return _userrepo.GetRole(new Role { Id = new Guid(roleid) });
        }

        public User Getuser(string userid)
        {
            if (string.IsNullOrWhiteSpace(userid))
            {
                return null;
            }
            var Id = new Guid(userid);
            if (Guid.Empty.Equals(Id))
            {
                return null;
            }
            return _userrepo.GetUser(new User { Id = new Guid(userid) });
        }

        public void AssignRole(string userid, string roleid)
        {
            var user = Getuser(userid);
            var role = GetRole(roleid);
            _userrepo.AssignRole(user, role);
        }

        public void DeleteUser(string userid)
        {
            var user = Getuser(userid);
            if(user != null)
            {
                _userrepo.DeleteUser(user);
            }
        }

        public Node FilterByRole(string roleid, Node node)
        {
            if(node == null)
            {
                return null;
            }
            var role = GetRole(roleid);
            var noderolemap = role.NodeRoleMaps.Where(x => x.NodeId == node.Id && x.NonReadable == true).FirstOrDefault();
            if(noderolemap == null)
            {
                return node;
            }
            else
            {
                return null;
            }
        }

        public Node FilterByUser(User user, Node node)
        {
            foreach (var role in user.RoleUserMaps.Select(x => x.RoleId))
            {
                node = FilterByRole(role.ToString(), node);
            }
            return node;
        }

        public Node FilterByUser(string userid, Node node)
        {
            var user = Getuser(userid);
            return FilterByUser(user, node);
        }

        public IEnumerable<Node> FilterByRole(string roleid, IEnumerable<Node> nodes)
        {
            var role = GetRole(roleid);
            var noderolemaps = role.NodeRoleMaps;
            return nodes.Where(x => noderolemaps.Any(y => y.NodeId != x.Id || (y.NodeId == x.Id && y.NonReadable != true)));
        }

        public IEnumerable<Node> FilterByUser(User user, IEnumerable<Node> nodes)
        {
            foreach (var role in user.RoleUserMaps.Select(x => x.RoleId))
            {
                nodes = FilterByRole(role.ToString(), nodes);
            }
            return nodes;
        }

        public IEnumerable<Node> FilterByUser(string userid, IEnumerable<Node> nodes)
        {
            var user = Getuser(userid);
            return FilterByUser(user, nodes);
        }
    }
}
