import unittest

import nullable/norm/mongodb


const
  # for local testing, modify your /etc/hosts file to contain "mongodb_1"
  # pointing to your local mongodb server
  dbConnection = "mongodb://mongodb_1:27017"
  dbName = "TestDb"
  customDbName = "TestCustomDb"

type
  Copyright = object
    legalName: N[string]
    year: N[int]

dbAddObject(Copyright)

db(dbConnection, "", "", dbName):
  type
    User {.table: "users".} = object
      email {.unique.}: N[string]
      ssn: N[int]
      birthDate: Time
    Publisher {.table: "publishers".} = object
      title {.unique.}: N[string]
    Book {.table: "books".} = object
      title: N[string]
      authorEmail: N[string]
      publisherTitle : string
      ratings: seq[float]
      copyright: Copyright
    Mix = object
      sorter: int
      s: N[string]
      i: N[int]
      f: N[float]
      b: N[bool]
      t: N[Time]
      o: N[Oid]


type
  Edition {.table: "editions".} = object
    id {.dbCol: "_id".}: Oid
    title: N[string]
    book: Book

dbAddCollection(Edition)

suite "nullable/norm/mongodb - CRUD":
  setup:
    var 
      user_reference_id: array[1..9, Oid]
      publisher_reference_id: array[1..9, Oid]
      book_reference_id: array[1..9, Oid]
      edition_reference_id: array[1..9, Oid]
      mix_reference_id: array[1..3, Oid]
      expected_object_str: array[1..3, string]

    withDb:
      createTables(force=true)

      for i in 1..9:
        var
          user = User(
            email: "test-$#@example.com" % $i, 
            ssn: i,
            birthDate: parseTime("200$1-0$1-0$1" % $i, "yyyy-MM-dd", utc())
          )
          publisher = Publisher(
            title: "Publisher $#" % $i
          )
          book = Book(
            title: "Book $#" % $i, 
            authorEmail: user.email,
            publisherTitle: publisher.title,
            ratings: @[4.5, 9.6, 7.0],
            copyright: Copyright(legalName: "XY $# Corp" % $i, year: 1990 + i)
          )
          edition = Edition(
            title: "Edition $#" % $i
          )

        user.insert()
        user_reference_id[i] = user.id
        publisher.insert()
        publisher_reference_id[i] = publisher.id
        book.insert()
        book_reference_id[i] = book.id
        edition.book = book
        edition.insert()
        edition_reference_id[i] = edition.id

      var m = Mix(
        sorter: 1,
        s: "joe",
        i: null(int),
        f: nothing(float),
        b: false,
        t: null(Time),
        o: nothing(Oid)
      )
      m.insert()
      mix_reference_id[1] = m.id
      expected_object_str[1] = """{
    "_id" : {"$$oid": "$1"},
    "sorter" : 1,
    "s" : "joe",
    "i" : null,
    "b" : false,
    "t" : null
}""".format(m.id)

      m = Mix(
        sorter: 2,
        s: null(string),
        i: nothing(int),
        f: 99.32,
        b: null(bool),
        t: nothing(Time),
        o: parseOid("01234567890123456789aaaa")
      )
      m.insert()
      mix_reference_id[2] = m.id
      expected_object_str[2] = """{
    "_id" : {"$$oid": "$1"},
    "sorter" : 2,
    "s" : null,
    "f" : 99.31999999999999,
    "b" : null,
    "o" : {"$$oid": "01234567890123456789aaaa"}
}""".format(m.id)

      m = Mix(
        sorter: 3,
        s: nothing(string),
        i: 44,
        f: null(float),
        b: nothing(bool),
        t: parseTime("1999-12-31", "yyyy-MM-dd", utc()),
        o: null(Oid)
      )
      m.insert()
      mix_reference_id[3] = m.id
      expected_object_str[3] = """{
    "_id" : {"$$oid": "$1"},
    "sorter" : 3,
    "i" : 44,
    "f" : null,
    "t" : $2,
    "o" : null
}""".format(m.id, $m.t)


  # teardown:
  #   withDb:
  #     dropTables()

  test "Create records":
    withDb:
      let
        publishers = Publisher.getMany(100, sort = %*{"title": 1})
        books = Book.getMany(100, sort = %*{"title": 1})
        editions = Edition.getMany(100, sort = %*{"title": 1})
      let
        mixes = Mix.getMany(100, sort = %*{"sorter": 1})

      check len(publishers) == 9
      check len(books) == 9
      check len(editions) == 9

      check publishers[3].title == "Publisher 4"

      check books[5].title == "Book 6"
      check books[5].ratings == @[4.5, 9.6, 7.0]
      check books[5].copyright.legalName == "XY 6 Corp"
      check books[5].copyright.year == 1996

      check editions[7].title == "Edition 8"
      let cbt = editions[7].book.title.get()
      let bt = books[7].title.get()
      check cbt == bt

      check $mixes[0].toBson == expected_object_str[1]
      check $mixes[1].toBson == expected_object_str[2]
      check $mixes[2].toBson == expected_object_str[3]

  # test "Read records":
  #   withDb:
  #     var
  #       users: seq[User] = @[]
  #       # users = User().repeat 10
  #       publishers = Publisher().repeat 10
  #       books = Book().repeat 10
  #       editions = Edition().repeat 10

  #     users.getMany(20, offset=5, sort = %*{"ssn": 1})
  #     publishers.getMany(20, offset=5, sort = %*{"title": 1})
  #     books.getMany(20, offset=5, sort = %*{"title": 1})
  #     editions.getMany(20, offset=5, sort = %*{"title": 1})

  #     check len(users) == 4
  #     check users[0].ssn.get() == 6
  #     check users[^1].ssn.get() == 9

  #     check len(publishers) == 4
  #     check publishers[0].title == "Publisher 6"
  #     check publishers[^1].title == "Publisher 9"

  #     check len(books) == 4
  #     check books[0].title == "Book 6"
  #     check books[^1].title == "Book 9"

  #     check len(editions) == 4
  #     check editions[0].title == "Edition 6"
  #     check editions[^1].title == "Edition 9"

  #     var
  #       user = User()
  #       publisher = Publisher()
  #       book = Book()
  #       edition = Edition()

  #     user.getOne user_reference_id[8]
  #     publisher.getOne publisher_reference_id[8]
  #     book.getOne book_reference_id[8]
  #     edition.getOne edition_reference_id[8]

  #     check user.ssn == 8
  #     check publisher.title == "Publisher 8"
  #     check book.title == "Book 8"
  #     check edition.title == "Edition 8"

