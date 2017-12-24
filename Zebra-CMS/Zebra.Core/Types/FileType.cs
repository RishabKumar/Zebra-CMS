using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Zebra.Core.Context;
using Zebra.Core.Renderers;
using Zebra.DAL;
using Zebra.DataRepository.DAL;
using Zebra.DataRepository.Interfaces;

namespace Zebra.Core.Types
{
    class FileType : ViewRender
    {
        protected string filename;
        protected string encodedstring;
        IFileRepository repo = new FileRepository();

        public FileType(FieldContext context)
        {
            _context = context;
        }

        //called just after GetValue().
        public override string SaveValue()
        {
            string filename = _context.RawData.ToString();
            string id = string.Empty;
            if (!string.IsNullOrWhiteSpace(filename))
            {
                id = repo.SaveLargeMedia(FileRepository.TempDataPath + filename, filename);
                if (!string.IsNullOrWhiteSpace(_context.OldValue))
                {
                    repo.DeleteMedia(FileRepository.MediaLocalPath + _context.OldValue);
                }
                if (!string.IsNullOrWhiteSpace(_context.Value))
                {
                    repo.DeleteMedia(FileRepository.TempDataPath + _context.Value);
                }
            }
            return id;
        }

        //called just before saving data.
        public override string GetValue()
        {
            // -> add get value from database via a wrapper.
            string filename = _context.RawData == null ? string.Empty: _context.RawData.ToString();
            if (!string.IsNullOrWhiteSpace(filename))
            {
                _context.Value = filename;
            }
            else if (!string.IsNullOrWhiteSpace(_context.Value))
            {
                filename = _context.Value;
                try
                {
                    _context.Value = repo.GetMediaFilePath(filename); //FileRepository.MediaPath + _context.Value;
                //    _context.Value = "../handlers/mediahandler.ashx?file=" + filename;
                    return _context.Value;
                }
                catch(Exception e)
                {
                    _context.Value = "data:video/mp4;base64, " + Convert.ToBase64String(repo.GetMediaBytes(filename));
                }
            }
            return _context.Value;
        }

        public override string DoRender()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<div class='field'>").Append(_context.Name).Append("<p><input type='file' onchange='UploadFile(this)'/><input type='hidden' name='").Append(_context.FieldId).Append("' id='").Append(_context.FieldId).Append("'").Append(" value='" + _context.Value + "' /></p>");
            sb.AppendLine("<img width='100px' src='"+ GetValue() + "'/>");
            sb.AppendLine("<script type='text/javascript'>");

            sb.AppendLine(@"function UploadFile(e)
            {
                showLoader();
                var data = new FormData(); 
                var file = e.files[0];
                var index = 0;
                var chunksize = 15120000; 
                var indexend = chunksize;  
                var size = file.size;
                var part = 1001;
                var filename = '';
                var ajaxRequest = $.ajax(
                {
                    type: 'GET',
                    url: '/zebraapi/MediaService/GetUniqueMediaId?filename='+file.name,
                    contentType: false,
                    processData: false,
                    async : false,
                    success: function (newname) {
                        if (newname !== '' && newname !== 'null') {
                            filename = newname;
                        }
                    },
                    error: function() {
                            hideLoader();
                    }
                });
                
                if ( size > 0) 
                {
                    var promises = [];
                    while( indexend != size && index < size)
                    {
                        if( indexend < size )
                        {
                            
                        }
                        else if( indexend > size )
                        {
                            indexend = size;
                        }

                        var blob = file.slice(index, indexend);
                        var data = new FormData();
                        data.append('UploadedImage', blob);
                        promises.push(SendChunk(data, filename, part));
                        
                        index += chunksize;
                        indexend += chunksize;
                        part++;
                    }
                    $.when.apply(null, promises).done(function(){
                        CompleteUpload(filename);
                    });
                }  
                

           //       data.append('UploadedImage', file[0]);
            }

            function CompleteUpload(filename)
            {
                var ajaxRequest = $.ajax(
                {
                    type: 'POST',
                    url: '/zebraapi/MediaService/MergeTempMedia?filename='+filename,
                    contentType: false,
                    processData: false,
                    success: function ( ) {
                        $('#" + _context.FieldId + @"').val(filename);
                        hideLoader();
                    },
                    error: function() {
                            hideLoader();
                        }
                });
            }

            function SendChunk(formdata, filename, part)
            {
                var ajaxRequest = $.ajax(
                {
                    type: 'POST',
                    url: '/zebraapi/MediaService/UploadFile?filename='+filename+'&part='+part,
                    contentType: false,
                    processData: false,
                    data: formdata,
                    success: function (tmpid) {
                    },
                    error: function() {
                        hideLoader();
                    }
                });
                ajaxRequest.done(function(data, textStatus, jqXHR) {
                    console.log(data);
                });
                return ajaxRequest;
            }
            ");

            sb.AppendLine("</script>");
            
            sb.AppendLine("</div>");
            return sb.ToString();
        }
    }
}
