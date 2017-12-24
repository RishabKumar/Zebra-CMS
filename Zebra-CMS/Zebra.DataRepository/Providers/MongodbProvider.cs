using MongoDB.Bson;
using MongoDB.Driver;
using MongoDB.Driver.GridFS;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zebra.DataRepository.Providers
{
    class MongodbProvider : MediaProvider
    {
        protected static IMongoClient _client;
        protected static IMongoDatabase _database;
        protected static IGridFSBucket _gridbucket;
        
        public MongodbProvider(string path, string medialocalpath, dynamic config) : base(path, medialocalpath, (object)config)
        {
            //_client = new MongoClient(MongoUrl.Create("mongodb://127.0.0.1:27017"));
            //_database = _client.GetDatabase("zebramedia");
             _client = new MongoClient(MongoUrl.Create(config[0].host.Value+":"+ config[0].port.Value));
            _database = _client.GetDatabase(config[0].db.Value);
            _gridbucket = new GridFSBucket(_database);
        }

        public override void DeleteMedia(string fileid)
        {
            ObjectId id;
            if (ObjectId.TryParse(fileid, out id))
            {
                _gridbucket.Delete(id);
            }
        }

        public override byte[] GetMediaBytes(string filename)
        {
            ObjectId id;
            byte[] bytes = null;
            if(ObjectId.TryParse(filename, out id))
            {
                bytes = _gridbucket.DownloadAsBytes(id);
            }
            return bytes ?? new byte[1];
        }

        public override byte[] GetMediaBytesByIndex(string filename, int startindex, int count)
        {
            ObjectId id;
            byte[] bytes = new byte[count];
            if (ObjectId.TryParse(filename, out id))
            {
                var options = new GridFSDownloadOptions
                {
                    Seekable = true
                };
                using (var stream = new BufferedStream(_gridbucket.OpenDownloadStream(id, options)))
                if (stream.CanSeek)
                {
                    //stream.Position += startindex;
                    stream.Seek(startindex,SeekOrigin.Begin);
                    stream.Read(bytes, 0, count);
                }
                //bytes = _gridbucket.DownloadAsBytes(id);
            }
            return bytes ?? new byte[1];
        }

        public override string SaveLargeMedia(string sourcepath, string filename)
        {
            var fs = new FileStream(sourcepath, FileMode.Open);
            var id = _gridbucket.UploadFromStream(filename, fs);
            return id.ToString();
        }

        public override string SaveMedia(string filename, byte[] bytes)
        {
            var id = _gridbucket.UploadFromBytes(filename, bytes);
            return id.ToString();
        }

        public override string GetMediaFilePath(string filename)
        {
            return "../handlers/videohandler.ashx?file=" + filename;
        }

        public override string GetMediaLocalFilePath(string filename)
        {
            throw new NotImplementedException();
        }

        public override long GetMediaLength(string filename)
        {
            ObjectId id;
            long length = -1;
            if (ObjectId.TryParse(filename, out id))
            {
                using (var stream = _gridbucket.OpenDownloadStream(id))
                {
                    length = stream.Length;
                }
                
                //bytes = _gridbucket.DownloadAsBytes(id);
            }
            return length;
        }
    }
}
