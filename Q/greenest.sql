select *
from (
         SELECT DISTINCT ON (p.id) near_images.distance, p.*, pi.url
         from product_images pi
                  join (select sum(cube_distance('(0,255,0)'::cube, pantone)) distance, image_id
                        from colors
                        group by image_id
                        order by 1 asc) near_images on near_images.image_id = pi.id
                  join products p on pi.product_id = p.id
         order by p.id, near_images.distance asc
     ) result
order by result.distance, result.id;
