(require '[honeysql.core :as sql]
         '[honeysql.helpers :refer :all :as helpers])

-- Everything is built on top of maps representing SQL queries:

(def sqlmap {:select [:a :b :c]
             :from [:foo]
             :where [:= :f.a "baz"]})
-- format turns maps into clojure.java.jdbc-compatible, parameterized SQL:

(sql/format sqlmap)
=> ["SELECT a, b, c FROM foo WHERE f.a = ?" "baz"]

(jdbc/query conn (sql/format sqlmap))

(sql/build :select :*
           :from :foo
           :where [:= :f.a "baz"])
=> {:where [:= :f.a "baz"], :from [:foo], :select [:*]}
-- You can provide a "base" map as the first argument to build:

(sql/build sqlmap :offset 10 :limit 10)
=> {:limit 10
    :offset 10
    :select [:a :b :c]
    :where [:= :f.a "baz"]
    :from [:foo]}

-- There are functions for each clause type in the honeysql.helpers namespace:

(-> (select :a :b :c)
    (from :foo)
    (where [:= :f.a "baz"]))

-- Order doesn't matter

(= (-> (select :*) (from :foo))
   (-> (from :foo) (select :*)))
=> true

-- When using the vanilla helper functions, new clauses will replace old clauses:

(-> sqlmap (select :*))
=> '{:from [:foo], :where [:= :f.a "baz"], :select (:*)}

-- To add to clauses instead of replacing them, use merge-select, merge-where, etc.:

(-> sqlmap
    (merge-select :d :e)
    (merge-where [:> :b 10])
    sql/format)
=> ["SELECT a, b, c, d, e FROM foo WHERE (f.a = ? AND b > ?)" "baz" 10]

-- where will combine multiple clauses together using and:

(-> (select :*)
    (from :foo)
    (where [:= :a 1] [:< :b 100])
    sql/format)
=> ["SELECT * FROM foo WHERE (a = ? AND b < ?)" 1 100]

/* Inserts are supported in two patterns. In the first pattern, you must explicitly specify the columns to insert, then provide a collection of rows, each a collection of column values: */

(-> (insert-into :properties)
    (columns :name :surname :age)
    (values
     [["Jon" "Smith" 34]
      ["Andrew" "Cooper" 12]
      ["Jane" "Daniels" 56]])
    sql/format)
=> [#sql/regularize
    "INSERT INTO properties (name, surname, age)
     VALUES (?, ?, ?), (?, ?, ?), (?, ?, ?)"
    "Jon" "Smith" 34 "Andrew" "Cooper" 12 "Jane" "Daniels" 56]
