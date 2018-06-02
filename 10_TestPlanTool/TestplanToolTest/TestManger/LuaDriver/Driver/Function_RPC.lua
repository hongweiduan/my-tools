-- generateDate : 2018-05-11 11:17:38
local function_table = {
------------------------functions.version----------------------------------
version.maccheck               =  require("functions.version").macCheck,
version.driverver              =  require("functions.version").DriverVer,
version.power                  =  require("functions.version").Power,
version.zynq                   =  require("functions.version").Zynq,
version.getversion             =  require("functions.version").GetVersion,
version.vendorid               =  require("functions.version").VendorId,
------------------------functions.fixture----------------------------------
fixture.skip                   =  require("functions.fixture").Skip,
fixture.gettesttime            =  require("functions.fixture").getTestTime,
fixture.delay                  =  require("functions.fixture").delay,
fixture.calculator             =  require("functions.fixture").Calculator,
------------------------functions.dmm----------------------------------
dmm.dmm                        =  require("functions.dmm").Dmm,
------------------------functions.eload----------------------------------
eload.eload                    =  require("functions.eload").eload,
------------------------functions.powersupply----------------------------------
powersupply.power              =  require("functions.powersupply").power,
------------------------functions.communication----------------------------------
communication.testsockethub    =  require("functions.communication").testSocketHub,
communication.testuarthub      =  require("functions.communication").testUartHub,
communication.testuartatouartb =  require("functions.communication").testUartaToUartb,
communication.testusbhub       =  require("functions.communication").testUsbHub,
------------------------functions.program----------------------------------
program.zynqreadid             =  require("functions.program").zynqReadId,
program.zynqreadtemp           =  require("functions.program").zynqReadTemp,
program.zynqflashread          =  require("functions.program").zynqFlashRead,
program.zynqprogram            =  require("functions.program").zynqProgram,
program.zynqflashwrite         =  require("functions.program").zynqFlashWrite,
------------------------functions.dut----------------------------------
dut.checkdutcommunication      =  require("functions.dut").CheckDUTCommunication,
dut.usbmode                    =  require("functions.dut").USBMode,
dut.signature                  =  require("functions.dut").Signature,
dut.sdclockrate                =  require("functions.dut").SDClockRate,
dut.getsamplepoint             =  require("functions.dut").GetSamplePoint,
dut.connect                    =  require("functions.dut").Connect,
dut.checkvalidwindow           =  require("functions.dut").CheckValidWindow,
dut.fwversion                  =  require("functions.dut").FWVersion,
dut.sdcarddetect               =  require("functions.dut").SDCardDetect,
dut.getcardtype                =  require("functions.dut").GetCardType,
dut.setsdpower                 =  require("functions.dut").SetSDPower,
dut.usb3testmode               =  require("functions.dut").USB3TestMode,
dut.disconnect                 =  require("functions.dut").Disconnect,
dut.wpcheck                    =  require("functions.dut").WPCheck,
------------------------functions.transfer----------------------------------
transfer.writesd1              =  require("functions.transfer").writeSD1,
transfer.readsd1               =  require("functions.transfer").readSD1,
transfer.readrdisk             =  require("functions.transfer").readRdisk,
transfer.ejectsd               =  require("functions.transfer").ejectSD,
transfer.updatedutlocation     =  require("functions.transfer").updateDUTLocation,
transfer.writerdisk            =  require("functions.transfer").WriteRdisk,
transfer.cardreaderinfo        =  require("functions.transfer").CardReaderInfo,
transfer.waitforsd             =  require("functions.transfer").waitForSD,
transfer.transfmeasvalue       =  require("functions.transfer").TransfMeasValue,
transfer.checksumtest          =  require("functions.transfer").CheckSumTest,
transfer.checkfilesize         =  require("functions.transfer").CheckFileSize,
transfer.sdinfo                =  require("functions.transfer").SDinfo,
transfer.readsd                =  require("functions.transfer").readSD,
transfer.countcurr             =  require("functions.transfer").CountCurr,
transfer.writesd               =  require("functions.transfer").WriteSD,
transfer.writesd2              =  require("functions.transfer").writeSD2,
------------------------functions.reset----------------------------------
reset.reset_raw                =  require("functions.reset").reset_raw,
reset.disconnectusb            =  require("functions.reset").disconnectUsb,
reset.eload_reset              =  require("functions.reset").ELOAD_reset,
reset.power_down_reset         =  require("functions.reset").power_down_reset,
reset.reset                    =  require("functions.reset").reset,
------------------------functions.JLink----------------------------------
jlink.program                  =  require("functions.JLink").Program,
jlink.runscript                =  require("functions.JLink").RunScript,
jlink.setmlbsn                 =  require("functions.JLink").SetMLBSn,
jlink.readtemp                 =  require("functions.JLink").ReadTemp,
jlink.getjlinklogname          =  require("functions.JLink").getJlinkLogName,
------------------------functions.global----------------------------------
global.getboarddevicename      =  require("functions.global").GetBoardDeviceName,
global.sfccfg                  =  require("functions.global").sfccfg,
global.split                   =  require("functions.global").split,
global.setsyncflag             =  require("functions.global").SetSyncFlag,
global.initpanelinfo           =  require("functions.global").InitPanelInfo,
global.unlock                  =  require("functions.global").unlock,
global.sequnlock               =  require("functions.global").sequnlock,
global.sync                    =  require("functions.global").Sync,
global.unlockall               =  require("functions.global").unlockall,
global.seqlock                 =  require("functions.global").seqlock,
global.msg_box                 =  require("functions.global").msg_box,
global.lock                    =  require("functions.global").lock,
------------------------internal.power----------------------------------
power.parse                    =  require("internal.power").Parse,
power.relay                    =  require("internal.power").Relay,
power.sendcmd                  =  require("internal.power").SendCmd,
power.eeprom                   =  require("internal.power").Eeprom,
------------------------internal.zynq----------------------------------
zynq.startpingpulse            =  require("internal.zynq").StartPingPulse,
zynq.relay                     =  require("internal.zynq").Relay,
zynq.parse                     =  require("internal.zynq").Parse,
zynq.measfreq                  =  require("internal.zynq").MeasFreq,
zynq.sendcmd                   =  require("internal.zynq").SendCmd,
zynq.pwmdisable                =  require("internal.zynq").PwmDisable,
------------------------functions.control----------------------------------
control.setctrlflag            =  require("functions.control").SetCtrlFlag,
control.disconnect             =  require("functions.control").Disconnect,
control.sdcardin               =  require("functions.control").SDCardIn,
control.sdcardout              =  require("functions.control").SDCardOut,
control.connect                =  require("functions.control").Connect,
------------------------functions.querysfc----------------------------------
querysfc.getsbuild             =  require("functions.querysfc").GetSbuild,
------------------------functions.sequence----------------------------------
sequence.retrylfps             =  require("functions.sequence").RetryLFPS,

};

return function_table

