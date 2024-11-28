#include "napi/native_api.h"
#include <cstddef>
#include <cstring>
#include <js_native_api.h>
#include <sys/un.h>
#include <unistd.h>
#include <sys/types.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

using namespace std;
static napi_value Add(napi_env env, napi_callback_info info) {
    size_t requireArgc = 2;
    size_t argc = 2;
    napi_value args[2] = {nullptr};

    napi_get_cb_info(env, info, &argc, args, nullptr, nullptr);

    napi_valuetype valuetype0;
    napi_typeof(env, args[0], &valuetype0);

    napi_valuetype valuetype1;
    napi_typeof(env, args[1], &valuetype1);

    double value0;
    napi_get_value_double(env, args[0], &value0);

    double value1;
    napi_get_value_double(env, args[1], &value1);

    napi_value sum;
    napi_create_double(env, value0 + value1, &sum);

    return sum;
}
static napi_value Minus(napi_env env, napi_callback_info info) {
    // 获取 2 个参数，napi_value是对 JS 类型的封装
    size_t argc = 2;
    napi_value args[2] = {nullptr}; // 获取数据
    // 调用napi_get_cb_info方法，从 info 中读取传递进来的参数放入args里
    napi_get_cb_info(env, info, &argc, args, nullptr, nullptr);
    // 获取参数并校验类型
    napi_valuetype valueType;
    napi_typeof(env, args[0], &valueType);
    napi_valuetype valueType1;
    napi_typeof(env, args[1], &valueType1);
    // 调用napi_get_value_double把 napi_value 类型转换成 C++ 的 double 类型
    double valueOne;
    napi_get_value_double(env, args[0], &valueOne);
    double valueTwo;
    napi_get_value_double(env, args[1], &valueTwo);
    // 调用napi_create_double方法把 C++类型转换成 napi_value 类型
    napi_value value;
    napi_create_double(env, valueOne - valueTwo, &value);
    return value;
}
static napi_value Multiply(napi_env env, napi_callback_info info) {
    size_t argc = 2;
    napi_value args[2] = {nullptr};
    napi_get_cb_info(env, info, &argc, args, nullptr, nullptr);
    napi_valuetype valueType;
    napi_typeof(env, args[0], &valueType);
    napi_valuetype napi_valuetype1;
    napi_typeof(env, args[1], &napi_valuetype1);
    double value0;
    napi_get_value_double(env, args[0], &value0);
    double value1;
    napi_get_value_double(env, args[0], &value1);
    napi_value value;
    napi_create_double(env, value0 * value1, &value);
    return value;
}
static napi_value Division(napi_env env, napi_callback_info info) {
    size_t argc = 2;
    napi_value args[2] = {nullptr};
    napi_get_cb_info(env, info, &argc, args, nullptr, nullptr);

    napi_valuetype type;
    napi_typeof(env, args[0], &type);
    napi_valuetype type1;
    napi_typeof(env, args[1], &type1);

    double value;
    napi_get_value_double(env, args[0], &value);
    double value1;
    napi_get_value_double(env, args[1], &value1);
    napi_value val;
    napi_create_double(env, value * value1, &val);
    return val;
}

static napi_value Bq_GPIO_On(napi_env env, napi_callback_info info) {
    size_t argc = 1;
    napi_value args[1] = {nullptr};
    napi_get_cb_info(env, info, &argc, args, nullptr, nullptr);
    napi_valuetype valueType;
    napi_typeof(env, args[0], &valueType);

    char *ledPath = new char[150]{};
    size_t buffSize = 100;
    size_t realSize = 0;
    napi_get_value_string_utf8(env, args[0], ledPath, buffSize, &realSize);
    int fd;
    char *ret = new char[50]{};
    fd = open(ledPath, O_RDWR | O_TRUNC | O_NOCTTY);
    if (fd < 0) {
        strcpy(ret, "fail to open file");
    } else {
        strcpy(ret, "1");
        write(fd, "1", 1);
        close(fd);
    }
    napi_value returnValue = nullptr;
    napi_create_string_utf8(env, ret, strlen(ret), &returnValue);
    return returnValue;
}
static napi_value Bq_GPIO_Off(napi_env env, napi_callback_info info) {
    size_t argc = 1;
    napi_value args[1] = {nullptr};
    napi_get_cb_info(env, info, &argc, args, nullptr, nullptr);
    napi_valuetype valueType;
    napi_typeof(env, args[1], &valueType);
    char *ledPath = new char[150]{};
    size_t buffSize = 100;
    size_t realSize = 0;
    napi_get_value_string_utf8(env, args[0], ledPath, buffSize, &realSize);
    int fd;
    char *ret = new char[50]{};
    fd = open(ledPath, O_RDWR | O_TRUNC | O_NOCTTY);
    if (fd < 0) {
        strcpy(ret, "fail to open file");
    } else {
        strcpy(ret, "0");
        write(fd, "0", 1);
        close(fd);
    }
    napi_value returnValue = nullptr;
    napi_create_string_utf8(env, ret, strlen(ret), &returnValue);
    return returnValue;
}
static napi_value bq_GPIO_State(napi_env env, napi_callback_info info) {
    size_t argc = 1;
    napi_value args[1] = {nullptr};
    napi_get_cb_info(env, info, &argc, args, nullptr, nullptr);
    napi_valuetype valuetype0;
    napi_typeof(env, args[0], &valuetype0);

    char *ledPath = new char[150]{};
    size_t buffSize = 100;
    size_t realSize = 0;
    napi_get_value_string_utf8(env, args[0], ledPath, buffSize, &realSize);
    char *ret = new char[50]{};
    FILE *fp;
    char gpioValuePath[200];
    char gpioValue[2];

    snprintf(gpioValuePath, sizeof(gpioValuePath), "%s", ledPath);
    if (access(gpioValuePath, F_OK) == -1) {
        strcpy(ret, "Error: the GPIO is not exist");
        napi_value returnValue = nullptr;
        napi_create_string_utf8(env, ret, strlen(ret), &returnValue);
        return returnValue;
    }
    // 打开GPIO口值文件
    fp = fopen(gpioValuePath, "r");
    if (fp == NULL) {
        perror("Error opening GPIO value file");
        strcpy(ret, "Error opening GPIO value file");
    } else {
        // 读取GPIO口值
        if (fgets(gpioValue, sizeof(gpioValue), fp) == NULL) {
            perror("Error reading GPIO value");
            fclose(fp);
            strcpy(ret, "Error reading GPIO value");
        } else {

            strcpy(ret, gpioValue);
        }
    }
    fclose(fp);

    napi_value returnValue = nullptr;
    napi_create_string_utf8(env, ret, strlen(ret), &returnValue);
    return returnValue;
}
EXTERN_C_START
static napi_value Init(napi_env env, napi_value exports) {
    napi_property_descriptor desc[] = {
        {"add", nullptr, Add, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"minus", nullptr, Minus, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"multiply", nullptr, Multiply, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"division", nullptr, Division, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"bq_GPIO_On", nullptr, Bq_GPIO_On, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"bq_GPIO_Off", nullptr, Bq_GPIO_Off, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"bq_GPIO_State", nullptr, bq_GPIO_State, nullptr, nullptr, nullptr, napi_default, nullptr}};
    napi_define_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc);
    return exports;
}
EXTERN_C_END

static napi_module demoModule = {
    .nm_version = 1,
    .nm_flags = 0,
    .nm_filename = nullptr,
    .nm_register_func = Init,
    .nm_modname = "entry",
    .nm_priv = ((void *)0),
    .reserved = {0},
};

extern "C" __attribute__((constructor)) void RegisterEntryModule(void) {
    napi_module_register(&demoModule);
}
