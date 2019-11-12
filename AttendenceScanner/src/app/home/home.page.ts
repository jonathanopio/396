import { Component } from '@angular/core';
import { NavController } from '@ionic/angular';
import { BarcodeScanResult, BarcodeScanner } from '@ionic-native/barcode-scanner/ngx';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {
  // qrData = null;
  scannedCode = null;
  constructor( private BarcodeScanner : BarcodeScanner ) {
  }
  scanCode() {
    this.BarcodeScanner.scan().then(barcodeData => {
      this.scannedCode = barcodeData.text;
    })
  }
}
