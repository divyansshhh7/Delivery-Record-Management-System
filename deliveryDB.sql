CREATE TABLE CUSTOMER (
    Customer_ID   NUMBER PRIMARY KEY,
    Name          VARCHAR2(100) NOT NULL,
    Contact_No    VARCHAR2(15) NOT NULL,
    Email         VARCHAR2(100),
    Address       VARCHAR2(200),
    City          VARCHAR2(50),
    Pincode       VARCHAR2(10)
);
CREATE TABLE DELIVERY_AGENT (
    Agent_ID      NUMBER PRIMARY KEY,
    Name          VARCHAR2(100) NOT NULL,
    Contact_No    VARCHAR2(15) NOT NULL,
    Vehicle_Type  VARCHAR2(50),
    Area_Assigned VARCHAR2(100),
    Joining_Date  DATE
);

CREATE TABLE ORDER_DETAILS (
    Order_ID         NUMBER PRIMARY KEY,
    Customer_ID      NUMBER NOT NULL,
    Order_Date       DATE NOT NULL,
    Delivery_Address VARCHAR2(200),
    Order_Value      NUMBER(10,2),
    Delivery_Status  VARCHAR2(20) DEFAULT 'Pending'
        CHECK (Delivery_Status IN ('Pending','In Transit','Delivered','Cancelled')),
    FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID)
);

CREATE TABLE ASSIGNMENT (
    Assignment_ID   NUMBER PRIMARY KEY,
    Order_ID        NUMBER NOT NULL,
    Agent_ID        NUMBER NOT NULL,
    Assigned_Date   DATE NOT NULL,
    Delivery_Time   TIMESTAMP,
    Delivery_Status VARCHAR2(20) DEFAULT 'Assigned'
        CHECK (Delivery_Status IN ('Assigned','In Transit','Delivered','Failed')),
    FOREIGN KEY (Order_ID) REFERENCES ORDER_DETAILS(Order_ID),
    FOREIGN KEY (Agent_ID) REFERENCES DELIVERY_AGENT(Agent_ID)
);

CREATE TABLE PAYMENT (
    Payment_ID     NUMBER PRIMARY KEY,
    Order_ID       NUMBER NOT NULL UNIQUE,
    Payment_Mode   VARCHAR2(20)
        CHECK (Payment_Mode IN ('Cash','Card','UPI','Net Banking')),
    Payment_Status VARCHAR2(20) DEFAULT 'Pending'
        CHECK (Payment_Status IN ('Pending','Completed','Failed')),
    Transaction_ID VARCHAR2(50),
    FOREIGN KEY (Order_ID) REFERENCES ORDER_DETAILS(Order_ID)
);

CREATE TABLE COMPLAINT (
    Complaint_ID      NUMBER PRIMARY KEY,
    Order_ID          NUMBER NOT NULL,
    Customer_ID       NUMBER NOT NULL,
    Complaint_Type    VARCHAR2(100),
    Resolution_Status VARCHAR2(20) DEFAULT 'Open'
        CHECK (Resolution_Status IN ('Open','In Progress','Resolved')),
    FOREIGN KEY (Order_ID) REFERENCES ORDER_DETAILS(Order_ID),
    FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID)
);

INSERT INTO CUSTOMER VALUES (1, 'Rahul Sharma', '9876543210', 'rahul@gmail.com', '12 MG Road', 'Delhi', '110001');
INSERT INTO CUSTOMER VALUES (2, 'Priya Patel', '9845123456', 'priya@gmail.com', '45 Park Street', 'Mumbai', '400001');
INSERT INTO CUSTOMER VALUES (3, 'Amit Verma', '9712345678', 'amit@gmail.com', '78 Lake View', 'Bangalore', '560001');
INSERT INTO CUSTOMER VALUES (4, 'Sneha Gupta', '9634567890', 'sneha@gmail.com', '23 Civil Lines', 'Patiala', '147001');
INSERT INTO CUSTOMER VALUES (5, 'Karan Mehta', '9523456781', 'karan@gmail.com', '56 Model Town', 'Amritsar', '143001');

INSERT INTO DELIVERY_AGENT VALUES (1, 'Vijay Kumar', '9111222333', 'Bike', 'Delhi North', TO_DATE('2022-01-15', 'YYYY-MM-DD'));
INSERT INTO DELIVERY_AGENT VALUES (2, 'Ravi Singh', '9222333444', 'Scooter', 'Mumbai West', TO_DATE('2021-06-20', 'YYYY-MM-DD'));
INSERT INTO DELIVERY_AGENT VALUES (3, 'Suresh Yadav', '9333444555', 'Bike', 'Bangalore East', TO_DATE('2023-03-10', 'YYYY-MM-DD'));
INSERT INTO DELIVERY_AGENT VALUES (4, 'Manoj Tiwari', '9444555666', 'Van', 'Patiala Central', TO_DATE('2022-09-05', 'YYYY-MM-DD'));
INSERT INTO DELIVERY_AGENT VALUES (5, 'Deepak Nair', '9555666777', 'Bike', 'Amritsar South', TO_DATE('2023-07-01', 'YYYY-MM-DD'));

INSERT INTO ORDER_DETAILS VALUES (101, 1, TO_DATE('2024-01-10', 'YYYY-MM-DD'), '12 MG Road, Delhi', 1500.00, 'Delivered');
INSERT INTO ORDER_DETAILS VALUES (102, 2, TO_DATE('2024-01-12', 'YYYY-MM-DD'), '45 Park Street, Mumbai', 2300.00, 'Delivered');
INSERT INTO ORDER_DETAILS VALUES (103, 3, TO_DATE('2024-01-15', 'YYYY-MM-DD'), '78 Lake View, Bangalore', 850.00, 'In Transit');
INSERT INTO ORDER_DETAILS VALUES (104, 4, TO_DATE('2024-01-18', 'YYYY-MM-DD'), '23 Civil Lines, Patiala', 3200.00, 'Pending');
INSERT INTO ORDER_DETAILS VALUES (105, 5, TO_DATE('2024-01-20', 'YYYY-MM-DD'), '56 Model Town, Amritsar', 1100.00, 'Delivered');
INSERT INTO ORDER_DETAILS VALUES (106, 1, TO_DATE('2024-01-22', 'YYYY-MM-DD'), '12 MG Road, Delhi', 500.00, 'Cancelled');
INSERT INTO ORDER_DETAILS VALUES (107, 3, TO_DATE('2024-01-25', 'YYYY-MM-DD'), '78 Lake View, Bangalore', 1750.00, 'Pending');

INSERT INTO ASSIGNMENT VALUES (1, 101, 1, TO_DATE('2024-01-10', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-01-11 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Delivered');
INSERT INTO ASSIGNMENT VALUES (2, 102, 2, TO_DATE('2024-01-12', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-01-13 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Delivered');
INSERT INTO ASSIGNMENT VALUES (3, 103, 3, TO_DATE('2024-01-15', 'YYYY-MM-DD'), NULL, 'In Transit');
INSERT INTO ASSIGNMENT VALUES (4, 104, 4, TO_DATE('2024-01-18', 'YYYY-MM-DD'), NULL, 'Assigned');
INSERT INTO ASSIGNMENT VALUES (5, 105, 5, TO_DATE('2024-01-20', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-01-21 16:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Delivered');

INSERT INTO PAYMENT VALUES (1, 101, 'UPI', 'Completed', 'TXN100101');
INSERT INTO PAYMENT VALUES (2, 102, 'Card', 'Completed', 'TXN100102');
INSERT INTO PAYMENT VALUES (3, 103, 'Cash', 'Pending', NULL);
INSERT INTO PAYMENT VALUES (4, 104, 'Net Banking', 'Pending', NULL);
INSERT INTO PAYMENT VALUES (5, 105, 'UPI', 'Completed', 'TXN100105');
INSERT INTO PAYMENT VALUES (6, 106, 'Card', 'Failed', 'TXN100106');

INSERT INTO COMPLAINT VALUES (1, 101, 1, 'Late Delivery', 'Resolved');
INSERT INTO COMPLAINT VALUES (2, 102, 2, 'Damaged Package', 'In Progress');
INSERT INTO COMPLAINT VALUES (3, 105, 5, 'Wrong Item', 'Open');

COMMIT;

-- QUERY 1: View all customers
SELECT * FROM CUSTOMER;

-- QUERY 2: View all orders with customer names (JOIN)
SELECT o.Order_ID, c.Name AS Customer_Name, o.Order_Date, 
       o.Order_Value, o.Delivery_Status
FROM ORDER_DETAILS o
JOIN CUSTOMER c ON o.Customer_ID = c.Customer_ID;

-- QUERY 3: View full delivery details - customer + order + agent (MULTI JOIN)
SELECT o.Order_ID, c.Name AS Customer, a.Name AS Agent,
       o.Order_Value, o.Delivery_Status, asn.Assigned_Date
FROM ORDER_DETAILS o
JOIN CUSTOMER c ON o.Customer_ID = c.Customer_ID
JOIN ASSIGNMENT asn ON o.Order_ID = asn.Order_ID
JOIN DELIVERY_AGENT a ON asn.Agent_ID = a.Agent_ID;

-- QUERY 4: Total revenue from completed payments (AGGREGATE)
SELECT SUM(o.Order_Value) AS Total_Revenue
FROM ORDER_DETAILS o
JOIN PAYMENT p ON o.Order_ID = p.Order_ID
WHERE p.Payment_Status = 'Completed';

-- QUERY 5: Number of deliveries handled by each agent (GROUP BY)
SELECT a.Name AS Agent_Name, COUNT(asn.Order_ID) AS Total_Deliveries
FROM DELIVERY_AGENT a
JOIN ASSIGNMENT asn ON a.Agent_ID = asn.Agent_ID
GROUP BY a.Name;

-- QUERY 6: Orders grouped by delivery status (GROUP BY)
SELECT Delivery_Status, COUNT(*) AS Total_Orders
FROM ORDER_DETAILS
GROUP BY Delivery_Status;

-- QUERY 7: Customers who have placed more than 1 order (SUBQUERY)
SELECT Name FROM CUSTOMER
WHERE Customer_ID IN (
    SELECT Customer_ID FROM ORDER_DETAILS
    GROUP BY Customer_ID
    HAVING COUNT(*) > 1
);

-- QUERY 8: All pending orders with customer details (FILTER)
SELECT c.Name, c.Contact_No, o.Order_ID, o.Order_Value, o.Delivery_Address
FROM ORDER_DETAILS o
JOIN CUSTOMER c ON o.Customer_ID = c.Customer_ID
WHERE o.Delivery_Status = 'Pending';

-- QUERY 9: Payment summary per mode (GROUP BY + AGGREGATE)
SELECT Payment_Mode, COUNT(*) AS Total_Transactions
FROM PAYMENT
GROUP BY Payment_Mode;

-- QUERY 10: Create a VIEW for pending deliveries
CREATE VIEW PENDING_DELIVERIES AS
SELECT o.Order_ID, c.Name AS Customer, o.Delivery_Address,
       o.Order_Value, a.Name AS Agent
FROM ORDER_DETAILS o
JOIN CUSTOMER c ON o.Customer_ID = c.Customer_ID
JOIN ASSIGNMENT asn ON o.Order_ID = asn.Order_ID
JOIN DELIVERY_AGENT a ON asn.Agent_ID = a.Agent_ID
WHERE o.Delivery_Status = 'Pending';

SELECT * FROM PENDING_DELIVERIES;

SET SERVEROUTPUT ON;

-- Procedure (Assign an agent to an order)
CREATE OR REPLACE PROCEDURE assign_agent(
    p_assignment_id IN NUMBER,
    p_order_id      IN NUMBER,
    p_agent_id      IN NUMBER
) AS
BEGIN
    INSERT INTO ASSIGNMENT (Assignment_ID, Order_ID, Agent_ID, Assigned_Date, Delivery_Status)
    VALUES (p_assignment_id, p_order_id, p_agent_id, SYSDATE, 'Assigned');
    
    UPDATE ORDER_DETAILS
    SET Delivery_Status = 'In Transit'
    WHERE Order_ID = p_order_id;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Agent ' || p_agent_id || ' assigned to Order ' || p_order_id || ' successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

EXEC assign_agent(8, 106, 4);
select * from assignment;


-- Function (Total Revenue)
CREATE OR REPLACE FUNCTION get_total_revenue
RETURN NUMBER AS
    v_total NUMBER;
BEGIN
    SELECT SUM(o.Order_Value)
    INTO v_total
    FROM ORDER_DETAILS o
    JOIN PAYMENT p ON o.Order_ID = p.Order_ID
    WHERE p.Payment_Status = 'Completed';
    
    RETURN v_total;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Total Revenue: Rs.' || get_total_revenue);
END;


-- Trigger 
CREATE OR REPLACE TRIGGER trg_payment_status
AFTER UPDATE OF Payment_Status ON PAYMENT
FOR EACH ROW
BEGIN
    IF :NEW.Payment_Status = 'Completed' THEN
        UPDATE ORDER_DETAILS
        SET Delivery_Status = 'Delivered'
        WHERE Order_ID = :NEW.Order_ID;
        
        DBMS_OUTPUT.PUT_LINE('Order ' || :NEW.Order_ID || ' automatically marked as Delivered.');
    END IF;
END;
/

UPDATE PAYMENT
SET Payment_Status = 'Completed'
WHERE Order_ID = 104;


-- Cursor
DECLARE
    CURSOR c_orders IS
        SELECT o.Order_ID, c.Name, o.Order_Value, o.Delivery_Status
        FROM ORDER_DETAILS o
        JOIN CUSTOMER c ON o.Customer_ID = c.Customer_ID;
    
    rec c_orders%ROWTYPE;
BEGIN
    OPEN c_orders;
    LOOP
        FETCH c_orders INTO rec;
        EXIT WHEN c_orders%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Order: ' || rec.Order_ID || ' | ' || rec.Name || ' | Rs.' || rec.Order_Value || ' | ' || rec.Delivery_Status);
    END LOOP;
    CLOSE c_orders;
END;
/

BEGIN
    INSERT INTO ORDER_DETAILS VALUES (108, 2, SYSDATE, '45 Park Street, Mumbai', 1800.00, 'Pending');
    SAVEPOINT order_placed;
    
    INSERT INTO PAYMENT VALUES (7, 108, 'UPI', 'Pending', NULL);
    SAVEPOINT payment_done;
    
    INSERT INTO ASSIGNMENT VALUES (7, 108, 2, SYSDATE, NULL, 'Assigned');
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transaction successful.');
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK TO order_placed;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/