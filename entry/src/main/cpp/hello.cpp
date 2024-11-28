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

struct AddonData {
    napi_async_work asyncWork = nullptr;
    napi_deferred deferred = nullptr;
    napi_ref callback = nullptr;
    double args[2] = {0};
    double result = 0;
};

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

// 业务逻辑处理函数，由worker线程池调度执行。
static void addExecuteCB(napi_env env, void *data) {
    AddonData *addonData = (AddonData *)data;

    // 执行复杂计算，不阻塞主线程。此处用一个加法简单示意。
    addonData->result = addonData->args[0] + addonData->args[1];
}
static void addPromiseCompleteCB(napi_env env, napi_status status, void *data) {
    AddonData *addonData = (AddonData *)data;
    napi_value result = nullptr;
    napi_create_double(env, addonData->result, &result);
    napi_resolve_deferred(env, addonData->deferred, result);

    // 删除napi_ref对象
    if (addonData->callback != nullptr) {
        napi_delete_reference(env, addonData->callback);
    }

    // 删除异步工作项
    napi_delete_async_work(env, addonData->asyncWork);
    delete addonData;
    addonData = nullptr;
}

static napi_value addAsync(napi_env env, napi_callback_info info) {
    size_t argc = 3;
    napi_value args[3] = {nullptr};
    napi_get_cb_info(env, info, &argc, args, nullptr, nullptr);
    napi_valuetype valueType;
    napi_typeof(env, args[0], &valueType);
    napi_valuetype valueType1;
    napi_typeof(env, args[1], &valueType1);
    napi_valuetype valueType2;
    napi_typeof(env, args[2], &valueType2);
    if (valueType != napi_number || valueType1 != napi_number) {
        napi_throw_type_error(env, nullptr, "Wrong arguments. 2 numbers expected.");
        return NULL;
    }
    if (valueType2 != napi_function) {
        napi_throw_type_error(env, nullptr, "Callback function expected.");
        return nullptr;
    }
    auto addonData = new AddonData{
        .asyncWork = nullptr,
    };
    // 将接收到的参数传入用户自定义上下文数据
    napi_get_value_double(env, args[0], &addonData->args[0]);
    napi_get_value_double(env, args[1], &addonData->args[1]);
    napi_create_reference(env, args[2], 1, &addonData->callback);

    // 创建async work，创建成功后通过最后一个参数接收async work的handle
    napi_value resourceName = nullptr;
    napi_create_string_utf8(env, "addCallback", NAPI_AUTO_LENGTH, &resourceName);
    napi_create_async_work(env, nullptr, resourceName, addExecuteCB, addPromiseCompleteCB, (void *)addonData,
                           &addonData->asyncWork);
    // 将刚创建的async work加到队列，由底层去调度执行
    napi_queue_async_work(env, addonData->asyncWork);

    // 原生方法返回空对象
    napi_value result = 0;
    napi_get_null(env, &result);
    return result;
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
        {"bq_GPIO_State", nullptr, bq_GPIO_State, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"addAsync", nullptr, addAsync, nullptr, nullptr, nullptr, napi_default, nullptr}};
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
