using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using Zebra.DataRepository.Interfaces;
using Zebra.DataRepository.Models;
using Zebra.Models;

namespace Zebra.DataRepository.DAL
{
    public class UserRepository : BaseRepository<User>, IUserRepository
    {
        public void AssignRole(User user, Role role)
        {
            var roleusermap = GetRoleUserMap(role, user);
            if (roleusermap != null)
            {
                return;
            }
            else
            {
                using (var dbt = _context.Database.BeginTransaction())
                {
                    roleusermap = new RoleUserMap() { Id = Guid.NewGuid(), RoleId = role.Id, UserId = user.Id };
                    _context.RoleUserMaps.Add(roleusermap);
                    _context.SaveChanges();
                    dbt.Commit();
                    dbt.Dispose();
                }
            }
        }

        public Role CreateRole(Role role)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                role = _context.Roles.Add(role);
                _context.SaveChanges();
                dbt.Commit();
                dbt.Dispose();
            }
            return role;
        }

        public User CreateUser(User user)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                user = _context.Users.Add(user);
                _context.SaveChanges();
                dbt.Commit();
                dbt.Dispose();
            }
            return user;
        }

        public Role DeleteRole(Role role)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                role = _context.Roles.Remove(role);
                _context.SaveChanges();
                dbt.Commit();
                dbt.Dispose();
            }
            return role;
        }

        public User DeleteUser(User user)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                user = _context.Users.Remove(user);
                _context.SaveChanges();
                dbt.Commit();
                dbt.Dispose();
            }
            return user;
        }

        public override List<User> GetByCondition(Expression<Func<User, bool>> selector)
        {
            throw new NotImplementedException();
        }

        public override User GetByName(User t)
        {
            return _context.Users.Where(u => u.UserName.ToLower().Equals(t.UserName.ToLower())).FirstOrDefault();
        }

        public override List<User> GetListById(IEntity t)
        {
            throw new NotImplementedException();
        }

        public void RemoveRole(User user, Role role)
        {
            var roleusermap = _context.RoleUserMaps.Where(x => x.RoleId == role.Id && user.Id == x.UserId).FirstOrDefault();
            if (roleusermap != null)
            {
                using (var dbt = _context.Database.BeginTransaction())
                {
                    _context.RoleUserMaps.Remove(roleusermap);
                    _context.SaveChanges();
                    dbt.Commit();
                    dbt.Dispose();
                }
            }
            else
            {
                return;
            }
        }

        public void AddOrUpdatePermission(Node node, Role role, bool nonreadable, bool nonwritable)
        {
            var noderolemap = GetNodeRoleMap(node, role);
            if (noderolemap == null)
            {
                using (var dbt = _context.Database.BeginTransaction())
                {
                    noderolemap = new NodeRoleMap() { Id = Guid.NewGuid(), RoleId = role.Id, NodeId = node.Id, NonReadable = nonreadable, NonWritable = nonwritable };
                    _context.NodeRoleMaps.Add(noderolemap);
                    _context.SaveChanges();
                    dbt.Commit();
                    dbt.Dispose();
                }
            }
            else
            {
                using (var dbt = _context.Database.BeginTransaction())
                {
                    var tmp = _context.NodeRoleMaps.Find(noderolemap.Id);
                    tmp.NonReadable = nonreadable;
                    tmp.NonWritable = nonwritable;
                    _context.SaveChanges();
                    dbt.Commit();
                    dbt.Dispose();
                }
            }
        }

        public Role UpdateRole(Role role)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                var tmp = _context.Roles.Find(role.Id);
                tmp.RoleName = role.RoleName;
                _context.SaveChanges();
                dbt.Commit();
                dbt.Dispose();
            }
            return _context.Roles.Find(role.Id);
        }

        public User UpdateUser(User user)
        {
            using (var dbt = _context.Database.BeginTransaction())
            {
                var tmp = _context.Users.Find(user.Id);
                tmp.UserName = user.UserName;
                tmp.Password = user.Password;
                _context.SaveChanges();
                dbt.Commit();
                dbt.Dispose();
            }
            return _context.Users.Find(user.Id);
        }

        public NodeRoleMap GetNodeRoleMap(Node node, Role role)
        {
            var noderolemap = _context.NodeRoleMaps.Where(x => x.RoleId == role.Id && node.Id == x.NodeId).FirstOrDefault();
            return noderolemap;
        }

        public RoleUserMap GetRoleUserMap(Role role, User user)
        {
            return _context.RoleUserMaps.Where(x => x.RoleId == role.Id && user.Id == x.UserId).FirstOrDefault();
        }

        public List<Role> GetRolesOfUser(User user)
        {
            return _context.RoleUserMaps.Where(x => x.UserId == user.Id).Select(x => x.Role).ToList();
        }

        public List<Role> GetAllRoles()
        {
            return _context.Roles.ToList();
        }

        public List<User> GetAllUsers()
        {
            return _context.Users.ToList();
        }

        public Role GetRole(Role role)
        {
            return _context.Roles.Where(x => x.Id == role.Id).FirstOrDefault();
        }

        public User GetUser(User user)
        {
            return _context.Users.Where(x => x.Id == user.Id).FirstOrDefault();
        }
    }
}