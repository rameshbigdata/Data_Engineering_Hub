**What is Hadoop?**

      Hadoop is an open-source software framework written in Java for distributed storage and distributed processing of very large dataset on group of machines.
      Its a framework to solve big data problems.

**Hadoop Versions:**

      1.0 - Hadoop Distributed File System(HDFS) , Map Reduce(MR)
      2.0 - HDFS , Map Reduce , Yarn Resource Management(YARN)
      3.0 - Current with above components

**Hadoop Basic components:**

      Storage          -->   Hadoop Distributed File System (HDFS) – a distributed file-system that stores 
                       data on commodity machines, providing very high aggregate bandwidth across the cluster;
      Processing       -->   MapReduce – an implementation of the MapReduce programming 
                       model for large scale data processing
      Resource Manager -->   Hadoop YARN – a resource-management platform responsible for managing 
                       computing resources in clusters and using them for scheduling of users' applications

**Hadoop Ecosystem:**

      Hive        - Datawarehouse tool for data analysis.
                    Don't know Java and know SQL. Write code in SQL and this gets converted into MR internally and submitted into cluster. 
      Sqoop       - CLI that transfers data between relation databases(oracle) and Hadoop
      Pig         - Scripting language for data manipulation(clean the data) and convert unstructured data into structured.
      Hbase       - No SQL DB runs on top of HDFS.
      Oozie       - Scheduler to manage the jobs.
      Spark       - Distributed general purpose in-memory compute engine
