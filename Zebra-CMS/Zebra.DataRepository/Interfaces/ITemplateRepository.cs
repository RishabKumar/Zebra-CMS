using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using Zebra.DataRepository.Models;

namespace Zebra.DataRepository.Interfaces
{
    public interface ITemplateRepository
    {
        Template CreateTemplate(Template template);
        Template GetTemplate(IEntity entity);
        Template DeleteTemplate(IEntity entity);
        NodeTemplateMap AddInheritance(Node node, Template newparent);
        bool RemoveInheritance(Node node, Template parent);
        List<NodeTemplateMap> GetByCondition(Expression<Func<NodeTemplateMap, bool>> selector);
        List<Template> GetInheritedTemplate(Node node);
    }
}
