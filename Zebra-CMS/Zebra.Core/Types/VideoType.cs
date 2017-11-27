using System.Text;
using Zebra.Core.Context;

namespace Zebra.Core.Types
{
    class VideoType : FileType
    {
        public VideoType(FieldContext context) : base(context)
        {
            _context = context;
            filename = string.Empty;
            encodedstring = string.Empty;
        }

        public override string DoRender()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<div class='field'>").Append(_context.Name).Append("<p><input type='file' onchange='UploadFile(this)'/><input type='hidden' name='").Append(_context.FieldId).Append("' id='").Append(_context.FieldId).Append("'").Append(" value='" + _context.Value + "' /></p>");
            sb.AppendLine(@"<video width='400' controls>
                              <source src = '" + GetValue() + @"'>
                              Your browser does not support HTML5 video.
                            </video >");
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
