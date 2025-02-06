import 'dart:html' as html;
import '../data/models/order_model.dart';

void printReceiptWeb(Order order, double totalWithDelivery, double totalCost) {
  final formattedAddress = order.address.length > 30
      ? order.address.substring(0, 30) + '\n' + order.address.substring(30)
      : order.address;

  final receiptText = '''
COOKANTS ORDER
------------------------
Customer: ${order.customerName}
Phone: ${order.customerPhoneNumber}
Address: $formattedAddress
Payment: ${order.paymentMethod}

Items:
${order.items.map((item) => '${item.productName} - ${item.price} TK x ${item.quantity} = ${(item.price * item.quantity)} BDT').join('\n')}

------------------------
Total: ${totalCost} BDT
Delivery Charge: ${order.deliveryCharge} BDT
Grand Total: ${totalWithDelivery} BDT

Thank you for your order!
------------------------
''';


  // HTML structure for receipt
  final receiptHtml = '''
    <html>
      <head>
        <title>COOKANTS ORDER RECEIPT</title>
        <style>
          body { font-family: monospace; padding: 10px; white-space: pre; }
          .receipt { font-family: monospace; font-size: 10px; }
        </style>
      </head>
      <body>
        <div class="receipt">
          <pre>$receiptText</pre>
        </div>
        <script>
          window.onload = function() {
            window.print();
            window.onafterprint = function() {
              window.close();
            };
          };
        </script>
      </body>
    </html>
  ''';

  // Create a Blob with the HTML content
  final blob = html.Blob([receiptHtml], 'text/html');
  final url = html.Url.createObjectUrlFromBlob(blob);

  // Open a new window
  final newWindow = html.window.open(url, '_blank', 'width=600,height=400');

  // Ensure the content is printed when the new window is loaded

}
void printReceiptDownload(Order order, double totalWithDelivery, double totalCost) {
  final receiptHtml = '''
  <html>
    <head>
      <title>COOKANTS ORDER RECEIPT</title>
      <style>
        body { 
          font-family: monospace; 
          padding: 10px; 
          white-space: pre; 
          text-align: left;
        }
        table {
          width: 100%;
          border-collapse: collapse;
          margin: 10px 0;
        }
        th, td {
          padding: 8px 12px;
          text-align: left;
          border: 1px solid #ddd;
        }
        th {
          background-color: #f4f4f4;
        }
        .receipt-header {
          text-align: center;
          font-size: 14px; /* Smaller font size */
          margin-bottom: 10px;
        }
        .receipt-footer {
          text-align: center;
          font-size: 10px; /* Smaller font size */
          margin-top: 20px;
        }
        .total, .delivery, .grand-total {
          font-weight: bold;
        }
      </style>
    </head>
    <body>
      <div class="receipt">
        <div class="receipt-header">
          <h2>COOKANTS ORDER</h2>
        </div>
        <p><strong>Customer:</strong> ${order.customerName}</p>
        <p><strong>Phone:</strong> ${order.customerPhoneNumber}</p>
        <p><strong>Address:</strong> ${order.address}</p>
        <p><strong>Payment:</strong> ${order.paymentMethod}</p>

        <table>
          <thead>
            <tr>
              <th>Item Name</th>
              <th>Unit Price (TK)</th>
              <th>Quantity</th>
              <th>Total (BDT)</th>
            </tr>
          </thead>
          <tbody>
            ${order.items.map((item) {
    return '''
                <tr>
                  <td>${item.productName}</td>
                  <td>${item.price} TK</td>
                  <td>${item.quantity}</td>
                  <td>${(item.price * item.quantity)} BDT</td>
                </tr>
              ''';
  }).join('')}
          </tbody>
        </table>

        <p class="total">Total: ${totalCost} BDT</p>
        <p class="delivery">Delivery Charge: ${order.deliveryCharge} BDT</p>
        <p class="grand-total">Grand Total: ${totalWithDelivery} BDT</p>

        <div class="receipt-footer">
          <p>Thank you for your order!</p>
        </div>
      </div>

      <script>
        window.onload = function() {
          window.print();
          window.onafterprint = function() {
            window.close();
          };
        };
      </script>
    </body>
  </html>
''';


  // Create a Blob with the HTML content
  final blob = html.Blob([receiptHtml], 'text/html');
  final url = html.Url.createObjectUrlFromBlob(blob);

  // Open a new window
  final newWindow = html.window.open(url, '_blank', 'width=600,height=400');

  // Ensure the content is printed when the new window is loaded

}