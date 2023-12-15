CREATE TABLE "members" (
	"memberID"	number(4)		NOT NULL,
	"zipcode"	number(4)		NOT NULL,
	"LastName"	varchar2(50)		NULL,
	"firstName"	varchar2(50)		NULL,
	"email"	varchar2(100)		NULL,
	"phoneNumber"	varchar2(20)		NOT NULL,
	"addr1"	varchar2(50)		NULL,
	"addr2"	varchar2(50)		NULL
);

CREATE TABLE "address" (
	"zipcode"	number(4)		NOT NULL,
	"si_do"	varchar2(50)		NULL,
	"gu_gum"	varchar2(50)		NULL,
	"bungi"	varchar2(50)		NULL
);

CREATE TABLE "products" (
	"productID"	number(4)		NOT NULL,
	"proName"	varchar2(100)		NULL,
	"price"	number(10,2)		NULL,
	"cnt"	number(4)		NULL,
	"description"	varchar2(2000)		NULL
);

CREATE TABLE "order" (
	"orderID"	number(4)		NOT NULL,
	"memberID"	number(4)		NOT NULL,
	"productID"	number(4)		NOT NULL,
	"orderDate"	date		NULL,
	"orderCNT"	number(4)		NULL
);

ALTER TABLE "members" ADD CONSTRAINT "PK_MEMBERS" PRIMARY KEY (
	"memberID",
	"zipcode"
);

ALTER TABLE "address" ADD CONSTRAINT "PK_ADDRESS" PRIMARY KEY (
	"zipcode"
);

ALTER TABLE "products" ADD CONSTRAINT "PK_PRODUCTS" PRIMARY KEY (
	"productID"
);

ALTER TABLE "order" ADD CONSTRAINT "PK_ORDER" PRIMARY KEY (
	"orderID",
	"memberID",
	"productID"
);

ALTER TABLE "members" ADD CONSTRAINT "FK_address_TO_members_1" FOREIGN KEY (
	"zipcode"
)
REFERENCES "address" (
	"zipcode"
);

ALTER TABLE "order" ADD CONSTRAINT "FK_members_TO_order_1" FOREIGN KEY (
	"memberID"
)
REFERENCES "members" (
	"memberID"
);

ALTER TABLE "order" ADD CONSTRAINT "FK_products_TO_order_1" FOREIGN KEY (
	"productID"
)
REFERENCES "products" (
	"productID"
);

