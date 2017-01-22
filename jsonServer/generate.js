module.exports = function() {
   var faker = require("faker");
   var _ = require("lodash");
   return {
       photos: _.times(100, function(n) {
         var urlImage = faker.image.image()+"/"+(1+faker.random.number()%10)+"/";
         var thumbnailUrlImage = urlImage.replace("640/480", "128/96");
         return {
            id: n,
            albumId: (n/10) >> 0,
            title: faker.lorem.sentence(),
            url: urlImage,
            thumbnailUrl: thumbnailUrlImage,
            date: faker.date.past()
          };
       })
   };
};
