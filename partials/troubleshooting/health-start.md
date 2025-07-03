## Health

To verify the status of the **@insert serviceUpper** service, you have several options
available:

1. Using the `**@insert workerSnake** ping`/`op_panel ping` command:

   You can utilize the `**@insert workerSnake**/op_panel ping` command to check if the
   service is running. This command checks if the service node is active
   and prints “pong” when successful. If the node is stopped or unresponsive,
   it will display the message: “Node '$NAME\_HOST' not responding to pings.”

2. Using the `service` command:

   You can also use the service command to quickly check the status of the
   **@insert serviceUpper** service. Execute the following commands to verify its status:

   ```bash
   ~$ service **@insert workerSnake** status

   pong
   **@insert workerSnake** is running
   ```

3. Nagios

   Monitoring the status of the **@insert serviceUpper** service in the Onedata system can be
   achieved using Nagios, a popular monitoring tool. The monitoring information
   is accessible on a specific port and provides a basic overview of the status
   of all functional components of the **@insert serviceUpper** service.

   To monitor the service status, you can utilize our [Nagios script][]
   or employ a simple script as shown below: