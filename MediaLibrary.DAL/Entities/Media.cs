using MediaLibrary.DAL.Enumerations;
using System;

namespace MediaLibrary.DAL.Entities
{
    public class Media
    {

        public int Id { get; set; }
        public string Name { get; set; }
        public string Url { get; set; }
        public string Path { get; set; }
        public MediaType Type { get; set; }
        public Category Category { get; set; }
        public bool Done { get; set; }
        public DateTime DateOfAddition { get; set; }
    }
}