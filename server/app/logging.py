__author__ = 'drobisch'


logging_dict = {}
logging_dict['GPIO_LOG'] = True
logging_dict['RFID_LOG'] = True

def log(module, log):
    if logging_dict[module] == True:
        print log


def disable_logging():
    for key in logging_dict:
        logging_dict[key] = False

def enable_logging():
    for key in logging_dict:
        logging_dict[key] = True
