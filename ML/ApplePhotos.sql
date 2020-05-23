select
  photo,
  (
    select
      json_group_array(
        normalized_string
      )
    from
      labels
    where
    
    
# shows the machine learning labels that were applied to each photo by Apple Photos
select
  photo,
  (
    select
      json_group_array(
        normalized_string
      )
    from
      labels
    where
      labels.uuid = photos_with_apple_metadata.uuid
  ) as labels,
  date,
  albums,
  persons,
  ZOVERALLAESTHETICSCORE
from
  photos_with_apple_metadata
limit 40    
    
