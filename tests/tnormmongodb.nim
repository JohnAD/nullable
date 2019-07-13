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
    legalName: nstring
    year: nint

dbAddObject(Copyright)

db(dbConnection, "", "", dbName):
  type
    User {.table: "users".} = object
      email {.unique.}: nstring
      ssn: nint
      birthDate: Time
    Publisher {.table: "publishers".} = object
      title {.unique.}: nstring
    Book {.table: "books".} = object
      title: nstring
      authorEmail: nstring
      publisherTitle : string
      ratings: seq[float]
      copyright: Copyright

  # TODO proc getBookById(id: Oid): Book = withDb(Book.getOne id)
  # TODO add and test foreign key pulls in mongo

type
  Edition {.table: "editions".} = object
    id {.dbCol: "_id".}: Oid
    title: nstring
    book: Book

dbAddCollection(Edition)

suite "nullable/norm/mongodb - CRUD":
  setup:
    var 
      user_reference_id: array[1..9, Oid]
      publisher_reference_id: array[1..9, Oid]
      book_reference_id: array[1..9, Oid]
      edition_reference_id: array[1..9, Oid]

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

  teardown:
    withDb:
      dropTables()

  test "Create records":
    withDb:
      let
        publishers = Publisher.getMany(100, sort = %*{"title": 1})
        books = Book.getMany(100, sort = %*{"title": 1})
        editions = Edition.getMany(100, sort = %*{"title": 1})

      check len(publishers) == 9
      check len(books) == 9
      check len(editions) == 9

      check publishers[3].title == "Publisher 4"

      check books[5].title == "Book 6"
      check books[5].ratings == @[4.5, 9.6, 7.0]
      check books[5].copyright.legalName == "XY 6 Corp"
      check books[5].copyright.year == 1996

      check editions[7].title == "Edition 8"
      check editions[7].book == books[7]

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

